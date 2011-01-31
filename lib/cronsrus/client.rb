require 'httparty'

module Cronsrus
  class Client
    include HTTParty
    base_uri 'http://api.cronsrus.com'
    #format 
    #format :json
    # FIXME this would be ideal (freezing to a version)
    # but response is not autom. parsed
    #headers 'Accept' => 'application/vnd.cronsrus-v1+json'
    headers 'Accept' => 'application/json'

    def initialize(token=nil)
      #token ||= Rankcheck::Config[:cronsrus_token]
      token ||= Cronsrus.config['token']

      self.class.headers 'X-Cronsrus-Token' => token
    end

    def cronjobs
      Cronjob.new
    end

    class Cronjob
      def all
        self.class.parent.get('/cronjobs')
      end
    end


    def delete_cronjob(name)
      self.class.delete(cronjob_path(name))
    end

    def create_cronjob(cronjob)
      # cronjob e.g. {:name => 'job1', :timezone => Time.zone.name, :cron => '0 * * * *', :url => 'http://www.postbin.org/1b233yu'}
      # update:
      # self.class.put('/cronjobs/job1', {:body => cronjob})
      self.class.post('/cronjobs', {:body => cronjob})
    end

    def update_or_create_cronjob(cronjob)
      #Rails.logger.error "[Cronsrus.update_or_create_cronjob] cronjob: #{cronjob.inspect}"
      name = cronjob['name'] || cronjob[:name]
      if self.class.get(cronjob_path(name)).code == 200
        self.class.put(cronjob_path(name), {:body => cronjob})
      else
        create_cronjob(cronjob)
      end
    end

    protected
      def cronjob_path(name)
        "/cronjobs/#{name}"
      end
  end
end
