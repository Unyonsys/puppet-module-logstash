# Class: logstash::user
#
# logstash_homeroot must be passed.
class logstash::user (
  $logstash_homeroot = undef
) {

  # make sure the logstash::config class is declared before logstash::user
  Class['logstash::config'] -> Class['logstash::user']

}
