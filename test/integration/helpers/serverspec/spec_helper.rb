require 'serverspec'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

# Tells serverspec to use a login shell for running chkconfig/service,
# which prevents false error reports on Centos 5.
begin
  if File.read("/etc/redhat-release") =~ /release 5\./
    Specinfra.configuration.login_shell = true
  end
rescue SystemCallError
end
