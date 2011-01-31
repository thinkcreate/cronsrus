require 'cronsrus/resources/cronjob'

module Cronsrus
  module Resources
    def self.included(base)
      @@client = base
    end

    def self.client
      @@client
    end
  end
end
