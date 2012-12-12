class logstash::web::service {
  service { 'logstash-web':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
  }
}
