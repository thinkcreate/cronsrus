module Cronsrus
  class Config < Hash
    def self.load_file(yaml_path)
      self[YAML.load_file(yaml_path)]
    end

    def self.load(yaml)
      self[YAML.load(yaml)]
    end
  end
end
