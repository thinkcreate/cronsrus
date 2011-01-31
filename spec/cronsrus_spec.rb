require 'spec_helper'

describe Cronsrus do
  it 'should have a config' do
    config = Cronsrus.config
    config.class.should == Hash
    config.keys.should include(*['cronjobs','token'])
  end
end
