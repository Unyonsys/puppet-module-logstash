class logstash::indexer::service {
  service { 'logstash-indexer':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
  }
}
