# undo stub symlink to standard symlink
link '/etc/resolv.conf' do
    to '/run/systemd/resolve/resolv.conf'
    # Don't execute this if inside a docker container
    not_if { ::File.exists?('/.dockerenv') }
end

# Stop and disable dnsmasq
systemd_unit 'dnsmasq.service' do
   action [:disable, :stop]
   notifies :restart, 'service[consul]'
end

# Stop and disable systemd-resolved
systemd_unit 'systemd-resolved.service' do
    action [:disable, :stop]
    notifies :restart, 'service[consul]'
end

# Defined to avoid any issues with poise-*
service 'consul' do
  action [:nothing]
end
