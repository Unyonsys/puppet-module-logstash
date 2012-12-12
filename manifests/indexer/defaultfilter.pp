class indexer::defaultfilter {
  file { "${logstash::variables::conf_path}/indexer.d/20-default_fiter.conf":
    ensure => file,
    source => 'puppet:///modules/logstash/indexer/default_filter.conf',
    notify => Class['logstash::indexer::service']
  }
}
