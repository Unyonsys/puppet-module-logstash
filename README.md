#puppet-logstash#

This module started as a fork of simonmcc/puppet-logstash
It was rewritten to make things modular, and allow to easily add config snippet without
changing module templates

I kept what I liked from the original module:
* Supports grabbing logstash jar directly (jar's are packages right?  we just don't support them natively yet :-))
* templated init scripts for all java daemons (based on work by Josh Davis/Christian d'Heureuse)

The config is thinked as following:
- the shipper is repsponsible for reading/sending events
- the indexer process and index them
- the web display them

##Usage##

This example is making use of puppet3 hiera autolookup.

```manifest
include logstash
```

```hiera
logstash::shipper: true
logstash::indexer: true
logstash::web: true
```
The logstash::snippet define is usefull to add config elements.
Some "standard" ones are predefined and included by default. This is parameterized.

Want to add a new file to read:

```logstash::snippet { 'shipper_myfile':
    component   => 'shipper',
    plugin_type => 'input',
    plugin      => 'file',
    data        => {
      type      => 'syslog',
      path      => '[ "/var/log/myfile" ]',
    }
  }
```

#Extra info#
I was wondering how file read is handled exactly, so here is the "official" response from logstash author:

Files are followed in a way similar to "tail -0F" for 'files new to logstash'. If a file is known (say, if logstash is restarted), logstash will start at the last position in each file it know about and continue reading.

In general, the flow is like this:

* if a new file is found, start following at the end of the file.
* logstash always keeps track of the position in the file.
* if an old file is found (with a known position), it will resume at that position, unless the file has been truncated prior and at which case logstash will begin reading at the start of the file

The goal is to never lose events.

-Jordan

#Credit#
Based on lots of original work by Kris Buytaert & Joe McDonagh
https://github.com/KrisBuytaert/puppet-logstash
https://github.com/thesilentpenguin/puppet-logstash
https://github.com/simonmcc/puppet-logstash
