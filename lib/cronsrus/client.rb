require 'httparty'

require 'cronsrus/resources'
module Cronsrus
  class Client
    include HTTParty
    include Cronsrus::Resources

    base_uri 'http://api.cronsrus.com'
    #format :json
    # FIXME this would be ideal (freezing to a version)
    # but response is not autom. parsed
    #headers 'Accept' => 'application/vnd.cronsrus-v1+json'
    headers 'Accept' => 'application/json'

    def initialize(token=nil)
      token ||= Cronsrus.config['token']

      self.class.headers 'X-Cronsrus-Token' => token
    end

    def cronjobs
      # FIXME passing self to new think is better
      @cronjobs ||= Cronsrus::Resources::Cronjob.new
    end
  end
end
