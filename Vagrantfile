Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.box = ENV.fetch('VAGRANT_VM_BOX', 'opscode-ubuntu-14.04')
  config.vm.box_url = ENV.fetch('VAGRANT_VM_BOX_URL', 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-14.04_provisionerless.box')

  config.vm.define :bootstrap, primary: true do |guest|
    guest.vm.network :private_network, ip: '172.16.38.10'
    guest.vm.provision :chef_zero do |chef|
      chef.nodes_path = File.expand_path('../.vagrant/chef/nodes', __FILE__)
      chef.run_list = %w(recipe[consul::default])
    end
  end
end
