Vagrant.configure('2') do |config|
  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = :latest

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'opscode-ubuntu-12.04'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

  config.vm.define :bootstrap, primary: true do |guest|
    guest.vm.network :private_network, ip: '172.16.38.10'
    guest.vm.provision :chef_solo do |chef|
      chef.run_list = ['recipe[consul::default]', 'recipe[consul::ui]']
    end
  end
end
