# undo stub symlink to standard symlink
link '/etc/resolv.conf' do
    to '/run/systemd/resolve/resolv.conf'
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
