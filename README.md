# cron puppet module
This git repository was initially seeded from the following wiki page.

http://linuxman.wikispaces.com/Creating+a+cron+job+with+puppet

I'm not the author but I am a user of this function.


## cron_job ##

restart puppet agent weekly

	cron_job { "puppet-restart":
		interval        => "weekly",
		script          => "#!/bin/sh
	/etc/init.d/puppet restart
	"
	}
