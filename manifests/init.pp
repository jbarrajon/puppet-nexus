# Class: nexus
# ===========================
#
# Full description of class nexus here.
#
class nexus (
  $version               = $::nexus::params::version,
  $download_url          = $::nexus::params::download_url,
  $manage_group          = $::nexus::params::manage_group,
  $nexus_group           = $::nexus::params::nexus_group,
  $manage_user           = $::nexus::params::manage_user,
  $nexus_user            = $::nexus::params::nexus_user,
  $manage_home           = $::nexus::params::manage_home,
  $user_home             = $::nexus::params::user_home,
  $manage_work_directory = $::nexus::params::manage_work_directory,
  $recurse_work_dir      = $::nexus::params::recurse_work_dir,
  $manage_config         = $::nexus::params::manage_config,
  $config_template       = $::nexus::params::config_template,
  $config_options        = $::nexus::params::config_options,
  $manage_service        = $::nexus::params::manage_service,
  $service_script        = $::nexus::params::service_script,
  $service_template      = $::nexus::params::service_template,
  $service_options       = $::nexus::params::service_options,
  $service_ensure        = $::nexus::params::service_ensure,
  $service_enable        = $::nexus::params::service_enable,
) inherits ::nexus::params {

  case $version {
    /^2\.\d+\.\d+-\d+$/: {
      $platform = 'bundle'
      $work_directory = "${user_home}/sonatype-work/nexus"
      $config_directory = undef
      $config_file = "${user_home}/nexus/conf/nexus.properties"
    }
    /^3\.\d+\.\d+-\d+$/: {
      $platform = 'unix'
      $work_directory = "${user_home}/sonatype-work/nexus3"
      $config_directory = "${work_directory}/etc"
      $config_file = "${config_directory}/nexus.properties"
    }
    default: {
      fail('Invalid version')
    }
  }

  $release_archive = "nexus-${version}-${platform}.tar.gz"
  $release_directory = "${user_home}/nexus-${version}"

  include ::nexus::install
  include ::nexus::config
  include ::nexus::service

  Class['::nexus::install'] -> Class['::nexus::config'] ~> Class['::nexus::service']

}
