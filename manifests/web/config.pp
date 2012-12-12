class logstash::web::config {
  Class['logstash::web::config'] ~> Class['logstash::web::service']

  # startup script
  logstash::javainitscript { 'logstash-web':
    servicename    => 'logstash-web',
    serviceuser    => $logstash::user,
    servicegroup   => $logstash::group,
    servicehome    => $logstash::home,
    servicelogfile => "${logstash::variables::log_path}/web.log",
    servicejar     => $logstash::package::jar,
    serviceargs    => " web --backend elasticsearch:///\?local -l ${logstash::variables::log_path}/web.log",
    java_home      => $logstash::java_home,
  }
}
