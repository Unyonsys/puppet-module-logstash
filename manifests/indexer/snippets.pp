class logstash::indexer::snippets {
  @logstash::snippet { 'redis_input':
    component        => 'indexer',
    plugin_type      => 'input',
    plugin           => 'redis',
    data             => $logstash::redis_input_config
  }
  @logstash::snippet { 'indexer_syslog':
    component   => 'indexer',
    plugin_type => 'filter',
    plugin      => 'grok',
    data        => {
      type      => 'syslog',
      pattern   => '%{SYSLOGLINE}',
    }
  }
}
