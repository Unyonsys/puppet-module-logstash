# Class: logstash::user
#
class logstash::user {
  Class['logstash::user'] -> Class['logstash::indexer::config']

  file { $logstash::home:
    ensure => 'directory',
    owner  => $logstash::variables::user,
    group  => $logstash::variables::group,
  }
  user { $logstash::variables::user:
    ensure     => present,
    managehome => true,
    shell      => $logstash::variables::shell,
    system     => true,
    comment    => 'logstash system account',
    uid        => $logstash::uid,
    gid        => $logstash::gid,
    home       => $logstash::home,
  }
  group { $logstash::variables::group:
    ensure => present,
    gid    => $logstash::gid
  }
}
