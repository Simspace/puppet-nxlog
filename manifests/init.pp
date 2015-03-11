class nxlog (
  $nxlog_version= $nxlog::params::nxlog_version,
  $logstash_dest = $nxlog::params::logstash_dest,
  $logstash_dest_port = $nxlog::params::logstash_dest_port,
  $service_enabled = $nxlog::params::service_enabled,
) inherits nxlog::params {

  include staging

  if $::operatingsystem == 'windows'{
    $installer_name = "nxlog-ce-$nxlog_version.msi"

    acl { "${staging_windir}/nxlog/$installer_name":
      purge => true,
      permissions => [
         { identity => 'Administrators', rights => ['full'] },
         { identity => 'Everyone', rights => ['full'] },
      ],
      inherit_parent_permissions => false,
    }

    staging::file { $installer_name:
      source => "puppet:///modules/nxlog/$installer_name",
    }

    package { 'NXLOG-CE':
      ensure => $nxlog_version,
      source => "${staging_windir}\\nxlog\\$installer_name",
      require => [ Staging::File[$installer_name], Acl["${staging_windir}/nxlog/$installer_name"]],
    }
    $service_status = $service_enabled ? {
      'true'  => 'running',
      'false' => 'stopped',
    }
    service { 'nxlog' :
      ensure  => $service_status,
      require => Package['NXLOG-CE'],
    }
    file { "$::programfilesx86\\nxlog\\conf\\nxlog.conf" :
      ensure  => present,
      content => template('nxlog/nxlog.conf.erb'),
      require => Package['NXLOG-CE'],
      notify  => Service['nxlog'],
    }

  }
  else {
    fail("Module not supported on $::operatingsystem")
  }
}
