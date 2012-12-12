class logstash::shipper::service {
  Class['logstash::shipper::config'] ~> Class['logstash::shipper::service']

  service { 'logstash-shipper':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
  }
}
