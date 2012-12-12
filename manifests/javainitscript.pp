# templated java daemon script
define logstash::javainitscript (
  $servicename,
  $serviceuser,
  $servicegroup,
  $servicehome,
  $servicelogfile,
  $servicejar,
  $serviceargs,
  $java_home,
) {
  file { "/etc/init.d/${servicename}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template('logstash/javainitscript.erb')
  }
}
