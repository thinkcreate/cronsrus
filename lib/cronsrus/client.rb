require 'httparty'

require 'cronsrus/resources'

module Cronsrus
  class Client
    include HTTParty

    base_uri 'http://api.cronsrus.com'
    #format :json
    # FIXME this would be ideal (freezing to a version)
    # but response is not autom. parsed
    #headers 'Accept' => 'application/vnd.cronsrus-v1+json'
    headers 'Accept' => 'application/json'

    def initialize(options=nil)
      options ||= Cronsrus.config
      self.class.headers 'X-Cronsrus-Token' => options['token']
    end

    def cronjobs
      @cronjobs ||= Cronsrus::Resources::Cronjob.new(self)
    end
  end
end
