class logstash::variables {
  case $::osfamily {
    /(?i-mx:debian)/ : {
      $shell       = '/bin/false'
    }
    /(?i-mx:redhat)/ : {
      $shell       = '/sbin/nologin'
    }
    default : {
      fail('Unsupported operating system')
    }
  }
  $user               = 'logstash'
  $group              = 'logstash'
  $home_path          = '/var/lib/logstash'
  $conf_path          = '/etc/logstash'
  $log_path           = '/var/log/logstash'
  $bin_path           = '/usr/local/bin'
  $grok_patterns_path = '/etc/logstash/grok_patterns'
  $baseurl            = 'https://logstash.objects.dreamhost.com/release'
  $redis_input_config = {
    type           => 'redis-input',
    host           => '127.0.0.1',
    port           => '6379',
    data_type      => 'list',
    key            => 'logstash',
    message_format => 'json_event',
  }
  $redis_output_config = {
    host      => '127.0.0.1',
    port      => '6379',
    data_type => 'list',
    key       => 'logstash',
  }
}
