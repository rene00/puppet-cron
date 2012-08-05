class cron {

    service { "crond":
        name => $operatingsystem ? {
            Ubuntu => 'cron',
            default => 'crond',
        },
        subscribe => File["/etc/crontab"],
        ensure => running,
    }

    file { "/etc/crontab":
        owner => "root", 
        group => "root", 
        mode => 644,
        source => [ 
            "puppet:///files/global/etc/crontab.$hostname", 
            "puppet:///files/global/etc/crontab", 
        ]
    }

    file { "/etc/cron.allow":
        owner => "root", 
        group => "root", 
        mode => 644,
        source => "puppet:///files/global/etc/cron.allow",
    }

    file { "/etc/cron.deny":
        owner => "root", 
        group => "root", 
        mode => 644,
        source => "puppet:///files/global/etc/cron.deny"
    }

}

# http://linuxman.wikispaces.com/Creating+a+cron+job+with+puppet
# manage cron jobs in separate files - call with enable => "false" to delete the job
define cron_job( $enable = "true", $interval = "daily", $script = "", $package = "" ) {
    file { "/etc/cron.$interval/$name":
        content         => $script,
        ensure          => $enable ? {
            "false" => absent,
            default => file,
        },
        force           => true,
        owner           => root,
        group           => root,
        mode            => $interval ? {
            "d"     => 644,
            default => 755,
        },
        require         => $package ? {
            ""      => undef,
            default => Package[$package],
        },
    }
}
