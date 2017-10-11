# Class: nexus::install
# ===========================
#
class nexus::install (
  $manage_group          = $::nexus::manage_group,
  $nexus_group           = $::nexus::nexus_group,
  $manage_user           = $::nexus::manage_user,
  $nexus_user            = $::nexus::nexus_user,
  $manage_home           = $::nexus::manage_home,
  $user_home             = $::nexus::user_home,
  $download_url          = $::nexus::download_url,
  $release_archive       = $::nexus::release_archive,
  $release_directory     = $::nexus::release_directory,
  $manage_work_directory = $::nexus::manage_work_directory,
  $work_directory        = $::nexus::work_directory,
  $recurse_work_dir      = $::nexus::recurse_work_dir,
  $config_directory      = $::nexus::config_directory,
) inherits ::nexus {

  if $manage_group {
    group { $nexus_group :
      ensure => present,
    }
  }

  if $manage_user {
    user { $nexus_user :
      ensure     => present,
      comment    => 'Nexus User',
      gid        => $nexus_group,
      home       => $user_home,
      managehome => $manage_home,
      shell      => '/bin/sh', # required to start application via script.
      system     => true,
    }
  }

  archive { $release_archive :
    path          => "${user_home}/${release_archive}",
    source        => "${download_url}/${release_archive}",
    checksum_url  => "${download_url}/${release_archive}.sha1",
    checksum_type => 'sha1',
    extract       => true,
    extract_path  => $user_home,
    creates       => $release_directory,
    user          => $nexus_user,
    group         => $nexus_group,
    cleanup       => false,
  }

  file { $release_directory :
    ensure  => directory,
    owner   => $nexus_user,
    group   => $nexus_group,
    require => Archive[$release_archive],
  }

  file { "${user_home}/nexus":
    ensure => 'link',
    target => $release_directory,
  }

  if $manage_work_directory {
    file { $work_directory :
      ensure  => directory,
      owner   => $nexus_user,
      group   => $nexus_group,
      recurse => $recurse_work_dir,
      require => Archive[$release_archive],
    }
  }

  if $config_directory {
    file { $config_directory :
      ensure => directory,
      owner  => $nexus_user,
      group  => $nexus_group,
    }
  }

}
