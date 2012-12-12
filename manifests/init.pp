# = Class: logstash
#
# This is the shared config class for the logstash module, override the sensible defaults as you see fit
#
# == Actions:
#
# Primarily a config class for logstash
#
# == Requires:
#
# Requirements. This could be packages that should be made available.
#
# == Sample Usage:
# redis_provider = package|external
#                  package  - we'll declare and ensure a redis package, using $redis_version
#                  external - assume redis is being installed outside of this module
# == Todo:
#
# * Update documentation
#
class logstash (
  $indexer,
  $shipper,
  $web,
  $user                = $logstash::variables::user,
  $group               = $logstash::variables::group,
  $home                = $logstash::variables::home_path,
  $grok_patterns_path  = $logstash::variables::grok_patterns_path,
  $java_home           = $::java_home,
  $provider            = 'http',
  $version             = '1.1.5',
  $verbose             = 'no',
  $es_embedded         = true,
  $es_config           = {},
  $redis_input_config  = $logstash::variables::redis_input_config,
  $redis_output_config = $logstash::variables::redis_output_config,
  $indexer_defaults    = [ 'redis_input', 'indexer_syslog' ],
  $shipper_defaults    = [ 'shipper_syslog', 'shipper_multiline', 'shipper_output' ],
) inherits logstash::variables {

  validate_string( $java_home )

  include logstash::common
  include logstash::package

  if $indexer {
    include logstash::user
    include logstash::indexer::config
    include logstash::indexer::service
    include logstash::indexer::snippets
    if ! empty($indexer_defaults) {
      realize Logstash::Snippet[ $indexer_defaults ]
    }
  }
  if $shipper {
    include logstash::shipper::config
    include logstash::shipper::service
    include logstash::shipper::snippets
    if ! empty($shipper_defaults) {
      realize Logstash::Snippet[ $shipper_defaults ]
    }
  }
  if $web {
    include logstash::user
    include logstash::web::config
    include logstash::web::service
  }
}
