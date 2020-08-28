describe http 'http://localhost:8500/v1/acl/info/anonymous' do
  its('status') { should eq 200 }
  its('body') { should match('"ID":"anonymous"') }
  its('body') { should match('"Name":"Anonymous Token"') }
  its('body') { should match('"Type":"client"') }
  its('body') { should include '"Rules":""' }
end

describe file '/tmp/anonymous-notified' do
  it { should_not exist }
end

describe http 'http://localhost:8500/v1/acl/info/management_token' do
  its('status') { should eq 200 }
  its('body') { should match('[]') }
end

# describe file('/tmp/management_token-notified') do
#   it { should exist }
# end
#
# describe command('curl -s "http://localhost:8500/v1/acl/info/reader_token"') do
#   its(:exit_status) { should eq 0 }
#   its(:stdout) { should match('"ID":"reader_token"') }
#   its(:stdout) { should match('"Name":""') }
#   its(:stdout) { should match('"Type":"client"') }
#   its(:stdout) { should include '"Rules":"key \"dummykey\"' }
# end
