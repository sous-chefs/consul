require_relative '../spec_helper'

config_file = '/etc/consul/conf.d/consul.json'
confd_dir   = '/etc/consul/conf.d'

describe file(config_file) do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0640' }
end

describe file(confd_dir) do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0755' }
end

describe file("#{confd_dir}/consul_definition_check.json") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0644' }
end

describe file("#{confd_dir}/consul_watch_check.json") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0640' }
end
