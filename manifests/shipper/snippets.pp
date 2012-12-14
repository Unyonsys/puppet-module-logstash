class logstash::shipper::snippets {
  @logstash::snippet { 'shipper_syslog':
    component   => 'shipper',
    plugin_type => 'input',
    plugin      => 'file',
    data        => {
      type      => 'syslog',
      path      => '[ "/var/log/syslog", "/var/log/auth.log", "/var/log/cron.log", "/var/log/messages", "/var/log/secure", "/var/log/cron" ]',
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
