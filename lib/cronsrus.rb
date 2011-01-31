require 'cronsrus/config'
require 'cronsrus/client'

require 'yaml'

module Cronsrus
  extend self

  def config
    @config ||= Cronsrus::Config.load_file(config_file_path)
  end

  def config_file_path
    File.join(Rails.root, 'config/cronsrus.yml')
  end
end
