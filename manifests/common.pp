class logstash::common {
  file { $logstash::variables::conf_path:
    ensure  => 'directory',
  }
  file { $logstash::variables::log_path:
    ensure  => 'directory',
    owner   => $logstash::variables::user,
    group   => $logstash::variables::group,
  }
  # directory of grok patterns
  file { $logstash::variables::grok_patterns_path:
    ensure  => directory,
    recurse => remote,
    source  => 'puppet:///modules/logstash/grok_patterns',
  }
}
