# undo stub symlink to standard symlink
link '/etc/resolv.conf' do
    to '/run/systemd/resolve/resolv.conf'
end

# Stop and disable systemd-resolved
systemd_unit 'systemd-resolved.service' do
    action [:disable, :stop]
end
