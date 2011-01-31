require 'spec_helper'

describe Cronsrus::Config do
  describe "#load" do
    it 'returns a hash with the correct content' do
      config = Cronsrus::Config.load(<<-CONFIG)
        api_token: 12345
        cronjobs:
          minutely:
            cron: * * * * *
            url: http://example.org/1
          hourly:
            cron: 0 * * * *
            url: http://example.org/1
      CONFIG

      config.keys.should include(*['api_token','cronjobs'])
      config['cronjobs'].keys.should include(*['minutely','hourly'])
    end
  end
end

describe Cronsrus::Client do

end
