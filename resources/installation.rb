# frozen_string_literal: true

provides :consul_installation
unified_mode true

default_action :create

property :version, String, name_property: true
property :install_method, String, default: 'repository', equal_to: %w(repository binary)
property :checksum, String
property :archive_url, String

include ConsulCookbook::Helpers

def consul_program
  case install_method
  when 'binary'
    ::File.join('/opt/consul', version, 'consul')
  else
    '/usr/bin/consul'
  end
end

action :create do
  case new_resource.install_method
  when 'repository'
    case node['platform_family']
    when 'debian'
      package 'apt-transport-https' do
        action :install
      end

      gpg_asc_path = ::File.join(Chef::Config[:file_cache_path], 'hashicorp-archive-keyring.asc')

      remote_file gpg_asc_path do
        source 'https://apt.releases.hashicorp.com/gpg'
        mode '0644'
        notifies :run, 'execute[dearmor-hashicorp-gpg]', :immediately
        action :create
      end

      execute 'dearmor-hashicorp-gpg' do
        command "gpg --batch --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg #{gpg_asc_path}"
        creates '/usr/share/keyrings/hashicorp-archive-keyring.gpg'
        action :nothing
      end

      file '/etc/apt/sources.list.d/hashicorp.list' do
        content(lazy do
          codename = shell_out('grep -oP "(?<=UBUNTU_CODENAME=).*" /etc/os-release || lsb_release -cs').stdout.strip
          arch = consul_arch == 'amd64' ? 'amd64' : 'arm64'
          "deb [arch=#{arch} signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com #{codename} main\n"
        end)
        mode '0644'
        notifies :update, 'apt_update[hashicorp]', :immediately
      end

      apt_update 'hashicorp' do
        action :nothing
      end

      package 'consul' do
        version new_resource.version unless new_resource.version == 'latest'
        action :install
      end

    when 'rhel', 'amazon', 'fedora'
      yum_repository 'hashicorp' do
        description 'HashiCorp Stable - $basearch'
        baseurl 'https://rpm.releases.hashicorp.com/RHEL/$releasever/$basearch/stable'
        gpgkey 'https://rpm.releases.hashicorp.com/gpg'
        gpgcheck true
        only_if { platform_family?('rhel') }
      end

      yum_repository 'hashicorp' do
        description 'HashiCorp Stable - $basearch'
        baseurl 'https://rpm.releases.hashicorp.com/AmazonLinux/latest/$basearch/stable'
        gpgkey 'https://rpm.releases.hashicorp.com/gpg'
        gpgcheck true
        only_if { platform_family?('amazon') }
      end

      yum_repository 'hashicorp' do
        description 'HashiCorp Stable - $basearch'
        baseurl 'https://rpm.releases.hashicorp.com/fedora/$releasever/$basearch/stable'
        gpgkey 'https://rpm.releases.hashicorp.com/gpg'
        gpgcheck true
        only_if { platform_family?('fedora') }
      end

      package 'consul' do
        version new_resource.version unless new_resource.version == 'latest'
        action :install
      end

    when 'suse'
      # No official zypper repo — fall back to binary
      install_binary
    end

  when 'binary'
    install_binary
  end
end

action :remove do
  case new_resource.install_method
  when 'repository'
    package 'consul' do
      action :remove
    end
  when 'binary'
    link '/usr/local/bin/consul' do
      action :delete
    end

    directory ::File.join('/opt/consul', new_resource.version) do
      action :delete
      recursive true
    end
  end
end

action_class do
  include ConsulCookbook::Helpers

  def install_binary
    archive_url = new_resource.archive_url || binary_archive_url(new_resource.version)
    basename = binary_archive_basename(new_resource.version)
    archive_path = ::File.join(Chef::Config[:file_cache_path], basename)
    install_dir = ::File.join('/opt/consul', new_resource.version)

    remote_file archive_path do
      source archive_url
      checksum new_resource.checksum if new_resource.checksum
    end

    directory install_dir do
      recursive true
    end

    archive_file archive_path do
      destination install_dir
    end

    link '/usr/local/bin/consul' do
      to ::File.join(install_dir, 'consul')
    end
  end
end
