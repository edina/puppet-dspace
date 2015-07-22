class dspace::config {
  $db_url = hiera('db::url')
  $db_user = hiera('db::user')
  $db_pass = hiera('db::pass')

  $tomcat_port = hiera('tomcat::port')
  $tomcat_dir = hiera('tomcat::dir')

  $ds_root = $dspace::dsroot
  $ds_group = $dspace::dsgroup
  $ds_conf_dir = "${ds_root}/config"
  $ds_bin_dir = "${ds_root}/bin"
  $ds_hostname = $fqdn
  $ds_baseurl = hiera('ds::baseurl')
  $ds_url = hiera('ds::url')
  $ds_name = hiera('ds::name')
  $ds_handleurl = hiera('ds::handleurl')
  $ds_modules_conf_dir = "$ds_conf_dir/modules"

  $doi_user = hiera('doi::user')
  $doi_pass = hiera('doi::pass')
  $doi_prefix = hiera('doi::prefix')
  $doi_ns = hiera('doi::ns')

  $oai_sorage = hiera('oai::storage')

  $google_analyticskey= hiera('google::analyticskey', '')

  group { "group_$dspace::dsgroup":
    ensure => "present",
  }

  file { "${dspace::dsroot}":
    ensure => directory,
    mode    => '774',
    group   => $ds_group,
  }->
  file { "$ds_conf_dir":
    ensure => directory,
    mode    => '774',
    group   => $ds_group,
  }->
  file { "$ds_conf_dir/dspace.cfg":
    ensure  => present,
    content => template('dspace/dspace.cfg.erb'),
    mode    => '640',
    group   => $ds_group,
  }

  file { "$ds_modules_conf_dir":
    ensure => directory,
  }->
  file { "$ds_modules_conf_dir/oai.cfg":
    ensure  => present,
    content => template('dspace/oai.cfg.erb'),
  }
  file { "$ds_modules_conf_dir/discovery.cfg":
    ensure  => present,
    content => template('dspace/discovery.cfg.erb'),
  }
  file { "$ds_modules_conf_dir/solr-statistics.cfg":
    ensure  => present,
    content => template('dspace/solr-statistics.cfg.erb'),
  }

  file { "$ds_bin_dir":
    ensure => directory,
    mode    => '774',
    group   => $ds_group,
  }->
  file { "$ds_bin_dir/service.sh":
    ensure  => present,
    content => template('dspace/service.sh.erb'),
    mode    => '754',
    group   => $ds_group,
  }
}
