# Class: nexus::service
# ===========================
#
class nexus::service (
  $manage_service   = $::nexus::manage_service,
  $service_script   = $::nexus::service_script,
  $service_template = $::nexus::service_template,
  $service_options  = $::nexus::service_options,
  $service_ensure   = $::nexus::service_ensure,
  $service_enable   = $::nexus::service_enable,
) inherits ::nexus {

  if $manage_service {
    file { $service_script :
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($service_template),
      notify  => Service['nexus'],
    }
    service { 'nexus':
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }

}
