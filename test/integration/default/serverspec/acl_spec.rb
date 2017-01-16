require 'spec_helper'

describe command('curl -s "http://localhost:8500/v1/acl/info/anonymous"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match('"ID":"anonymous"') }
  its(:stdout) { should match('"Name":"Anonymous Token"') }
  its(:stdout) { should match('"Type":"client"') }
  its(:stdout) { should include '"Rules":""' }
end

describe file('/tmp/anonymous-notified') do
  it { should_not exist }
end

describe command('curl -s "http://localhost:8500/v1/acl/info/management_token"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match('[]') }
end

describe file('/tmp/management_token-notified') do
  it { should exist }
end

describe command('curl -s "http://localhost:8500/v1/acl/info/reader_token"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match('"ID":"reader_token"') }
  its(:stdout) { should match('"Name":""') }
  its(:stdout) { should match('"Type":"client"') }
  its(:stdout) { should include '"Rules":"key \"dummykey\"' }
end
