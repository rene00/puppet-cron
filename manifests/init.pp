class cron {  }

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
