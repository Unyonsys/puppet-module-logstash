define logstash::snippet (
  $component,   # indexer, shipper, web...
  $plugin_type, # input, filter, output
  $plugin,      # grok, exec, email
  $data,        # actual data
) {
  include logstash::variables

  Logstash::Snippet[ $name ] ~> Class["logstash::${component}::service"]

  $order = $plugin_type ? {
    'input'  => '10',
    'filter' => '20',
    'output' => '30',
  }
  file { "${logstash::variables::conf_path}/${component}.d/${order}-${name}":
    ensure  => file,
    content => template('logstash/generic-snippet.erb'),
    require => File[ "${logstash::variables::conf_path}/${component}.d" ],
  }
}
