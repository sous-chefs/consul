require 'spec_helper'

describe service('consul') do
  it { should be_running.under('runit') }
  it { should be_enabled }
end
