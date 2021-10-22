unified_mode true

default_action :run

property(:command, kind_of: String, name_property: true)
property(:environment, kind_of: Hash, default: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })
property(:options, kind_of: Hash, default: {})

action :run do
  options = new_resource.options.map do |k, v|
    next if v.is_a?(NilClass) || v.is_a?(FalseClass)
    if v.is_a?(TrueClass)
      "-#{k}"
    else
      ["-#{k}", v].join('=')
    end
  end

  command = ['/usr/bin/env consul exec',
             options,
             new_resource.command].flatten.compact

  converge_if_changed do
    execute command.join(' ') do
      environment new_resource.environment
    end
  end
end
