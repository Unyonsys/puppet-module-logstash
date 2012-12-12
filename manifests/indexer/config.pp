class logstash::indexer::config {
  Class['logstash::indexer::config'] ~> Class['logstash::indexer::service']

  file { "${logstash::variables::conf_path}/indexer.d":
    ensure  => 'directory',
    recurse => true,
    purge   => true,
  }

  # startup script
  logstash::javainitscript { 'logstash-indexer':
    servicename    => 'logstash-indexer',
    serviceuser    => $logstash::user,
    servicegroup   => $logstash::group,
    servicehome    => $logstash::home,
    servicelogfile => "${logstash::variables::log_path}/indexer.log",
    servicejar     => $logstash::package::jar,
    serviceargs    => " agent -f ${logstash::variables::conf_path}/indexer.d/ -l ${logstash::variables::log_path}/indexer.log --grok-patterns-path ${logstash::grok_patterns_path}",
    java_home      => $logstash::java_home,
  }

  # if we're running with elasticsearch embedded, make sure the data dir exists
  if $logstash::es_embedded {
    file { "${logstash::home}/data":
      ensure => directory,
      owner  => $logstash::user,
      group  => $logstash::group,
    }
    file { "${logstash::home}/data/elasticsearch":
      ensure => directory,
      owner  => $logstash::user,
      group  => $logstash::group,
    }
    logstash::snippet { 'elasticsearch_output':
      component        => 'indexer',
      plugin_type      => 'output',
      plugin           => 'elasticsearch',
      data             => {
        'embedded' => true,
      }
    }
  }
}
