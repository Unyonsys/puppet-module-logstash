# = Class: logstash::package
#
# Class to manage where we get the logstash jar from
#
# == Parameters:
#
# $version::   description of parameter. default value if any.
# $logstash::provider::   description of parameter. default value if any.
# ${logstash::variables::bin_path}::   description of parameter. default value if any.
# $baseurl:: Where to curl the jar file from if http is used
# defaults to http://semicomplete.com/files/logstash/
# $java_package::   description of parameter. default value if any.
#
# == Actions:
#
# Makes sure that a logstash jar is available, via http, puppet or package
#
# == Requires:
#
# $logstash::provider='http' is the simplest and most tested method,
# it just curl's the file into place, so you need internet access,
# unless you have mirror'd the file locally
#
# == Sample Usage:
#
# == Todo:
#
# * Add better support for other ways providing the jar file?
#
class logstash::package (
  $version  = $logstash::version,
) {

  $logstash_jar = sprintf('%s-%s-%s', 'logstash', $version, 'monolithic.jar')
  $jar = "${logstash::variables::bin_path}/${logstash_jar}"

  # put the logstash jar somewhere
  # logstash::provider = package|puppet|http

  # if we're using a package as the logstash jar logstash::provider,
  # pull in the package we need
  if $logstash::provider == 'package' {
    # Obviously I abused fpm to create a logstash package and put it on my
    # repository
    package { 'logstash':
      ensure => 'present',
    }
  }

  # You'll need to drop the jar in place on your puppetmaster
  # (puppetmaster file sharing isn't a great way to shift 50Mb+ files around)
  if $logstash::provider == 'puppet' {
    file { $jar:
      ensure => present,
      source => "puppet:///modules/logstash/${logstash_jar}",
    }
  }

  if $logstash::provider == 'http' {
    $url = "${logstash::variables::baseurl}/${logstash_jar}"

    realize Package['curl']

    # pull in the logstash jar over http
    exec { "curl -o ${jar} ${url}":
      timeout => 0,
      cwd     => '/tmp',
      creates => $jar,
      path    => ['/usr/bin', '/usr/sbin'],
      require => Package['curl'],
    }
  }

  if $logstash::provider == 'external' {
    notify { "It's up to you to provde ${jar}": }
  }
}
