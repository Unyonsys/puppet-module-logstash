class logstash::shipper::config {
  file { "${logstash::variables::conf_path}/shipper.d":
    ensure  => 'directory',
    recurse => true,
    purge   => true,
  }
  # startup script
  # shippet must run as root to be able to read all files
  # this might be finer grained in the future
  logstash::javainitscript { 'logstash-shipper':
    servicename    => 'logstash-shipper',
    serviceuser    => 'root',
    servicegroup   => 'root',
    servicehome    => '/tmp',
    servicelogfile => "${logstash::variables::log_path}/shipper.log",
    servicejar     => $logstash::package::jar,
    serviceargs    => " agent -f ${logstash::variables::conf_path}/shipper.d/ -l ${logstash::variables::log_path}/shipper.log --grok-patterns-path ${logstash::grok_patterns_path}",
    java_home      => $logstash::java_home,
  }
}
