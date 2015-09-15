source 'https://supermarket.chef.io'
cookbook 'chef-vault', git: 'https://github.com/johnbellone/chef-vault-cookbook'
metadata

group :test do
  cookbook 'consul_spec', path: 'test/cookbooks/consul_spec'
end

group :integration do
  cookbook 'consul_spec', path: 'test/cookbooks/consul_spec'
end
