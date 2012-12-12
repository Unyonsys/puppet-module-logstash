class logstash::shipper::snippets {
  @logstash::snippet { 'shipper_syslog':
    component   => 'shipper',
    plugin_type => 'input',
    plugin      => 'file',
    data        => {
      type      => 'syslog',
      path      => '[ "/var/log/messages", "/var/log/syslog", "/var/log/*.log" ]',
    }
  }
  @logstash::snippet { 'shipper_multiline':
    component   => 'shipper',
    plugin_type => 'filter',
    plugin      => 'multiline',
    data        => {
      'type'    => 'syslog',
      pattern   => '^\t',
      what      => 'previous'
    }
  }
  @logstash::snippet { 'shipper_output':
    component   => 'shipper',
    plugin_type => 'output',
    plugin      => 'redis',
    data        => $logstash::redis_output_config,
  }
}
