# Class: nexus::config
# ===========================
#
class nexus::config (
  $manage_config   = $::nexus::manage_config,
  $config_file     = $::nexus::config_file,
  $config_template = $::nexus::config_template,
  $config_options  = $::nexus::config_options,
  $nexus_group     = $::nexus::nexus_group,
  $nexus_user      = $::nexus::nexus_user,
) inherits ::nexus {

  if $manage_config {
    file { $config_file :
      ensure  => 'present',
      group   => $nexus_group,
      owner   => $nexus_user,
      mode    => '0640',
      content => template($config_template),
    }
  }

}
