# Class: nexus::params
# ===========================
#
class nexus::params {

  $version      = '2.14.2-01'
  $download_url = 'http://download.sonatype.com/nexus/oss'

  $manage_group = true
  $nexus_group  = 'nexus'
  $manage_user  = true
  $nexus_user   = 'nexus'
  $manage_home  = true
  $user_home    = '/srv/sonatype'
  $manage_work_directory = true
  $recurse_work_dir = true

  $manage_config   = true
  $config_template = 'nexus/nexus.properties.erb'
  $config_options  = {
    'Jetty section' => [
      'application-port=8081',
      'application-host=0.0.0.0',
      'nexus-webapp=${bundleBasedir}/nexus',
      'nexus-webapp-context-path=/',
    ],
    'Nexus section' => [
      'nexus-work=${bundleBasedir}/../sonatype-work/nexus',
      'runtime=${bundleBasedir}/nexus/WEB-INF',
    ],
    'orientdb buffer size in megabytes' => [
      'storage.diskCache.bufferSize=4096',
    ],
  }

  $manage_service   = true
  $service_ensure   = 'running'
  $service_enable   = true
  $service_script   = '/etc/systemd/system/nexus.service'
  $service_template = 'nexus/nexus.systemd.erb'
  $service_options  = {}

}
