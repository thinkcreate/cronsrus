require 'cronsrus/client'

require 'yaml'

module Cronsrus
  extend self

  def config
    YAML.load_file(File.join(Rails.root, 'config/cronsrus.yml'))
  end
end
