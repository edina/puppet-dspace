class dspace::config {
  $db_url  = hiera('db::url')
  $db_user = hiera('db::user')
  $db_pass = hiera('db::pass')

  $tomcat_port = hiera('common::tomcat::port')
  $tomcat_dir = hiera('common::tomcat::root')

  $ds_root             = $dspace::dsroot
  $ds_group            = $dspace::dsgroup
  $ds_conf_dir         = "${ds_root}/config"
  $ds_bin_dir          = "${ds_root}/bin"
  $ds_log_dir          = "${ds_root}/log"
  $ds_modules_conf_dir = "$ds_conf_dir/modules"
  $ds_solr_dir         = "${ds_root}/solr"
  $ds_tmp_dir         = "${ds_root}/tmp"
  $ds_hostname         = $fqdn
  $ds_baseurl          = hiera('ds::baseurl')
  $ds_datadir          = hiera('ds::datadir')
  $ds_handleprefix     = hiera('ds::handleprefix')
  $ds_handleurl        = hiera('ds::handleurl')
  $ds_maildisabled     = hiera('ds::maildisabled', 'false')
  $ds_mailfrom         = hiera('ds::mailfrom')
  $ds_mailserver       = hiera('common::smtp::host')
  $ds_name             = hiera('ds::name')
  $ds_url              = hiera('ds::url')

  $doi_user   = hiera('doi::user')
  $doi_pass   = hiera('doi::pass')
  $doi_prefix = hiera('doi::prefix')
  $doi_ns     = hiera('doi::ns')

  $oai_storage = hiera('oai::storage')
  $oai_cache  = hiera('oai::cache')

  $google_analyticskey = hiera('google::analyticskey', '')

  $sword_service_url = hiera('sword::servicedoc::url', "http://localhost:$tomcat_port/swordv2/servicedocument")

  group { "group_$dspace::dsgroup":
    ensure => "present",
  }

  file { "$ds_root":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_conf_dir":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_conf_dir/dspace.cfg":
    ensure  => present,
    content => template('dspace/dspace.cfg.erb'),
    mode    => '640',
    group   => $ds_group,
  }

  # modules
  file { "$ds_modules_conf_dir":
    ensure => directory,
  }->
  file { "$ds_modules_conf_dir/oai.cfg":
    ensure  => present,
    content => template('dspace/oai.cfg.erb'),
  }->
  file { "$ds_modules_conf_dir/discovery.cfg":
    ensure  => present,
    content => template('dspace/discovery.cfg.erb'),
  }->
  file { "$ds_modules_conf_dir/solr-statistics.cfg":
    ensure  => present,
    content => template('dspace/solr-statistics.cfg.erb'),
  }->
  file { "$ds_modules_conf_dir/swordv2-server.cfg":
    ensure  => present,
    content => template('dspace/swordv2-server.cfg.erb'),
  }

  # bin
  file { "$ds_bin_dir":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_bin_dir/service.sh":
    ensure  => present,
    content => template('dspace/service.sh.erb'),
    mode    => '774',
    group   => $ds_group,
  }->
  file { "$ds_bin_dir/batch_import.sh":
    ensure => present,
    source  =>  "puppet:///modules/dspace/batch_import.sh",
  }

  # assetstore
  if $ds_datadir != $ds_root {
    file { "$ds_datadir":
      ensure => directory,
      mode    => '775',
      group   => $ds_group,
    }
  }
  file { "$ds_datadir/assetstore":
    ensure => directory,
    mode    => '770',
    group   => $ds_group,
  }->
  exec { "asset_permissions":
    command => 'find . -type d -exec chmod 0770 {} \;',
    cwd     => "$ds_datadir/assetstore",
    path    => "/usr/bin/",
  }

  # log
  file { "$ds_log_dir":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }

  # log4j
  file { "$ds_conf_dir/log4j.properties":
    ensure  => present,
    content => template('dspace/log4j.properties.erb'),
  }
  file { "$ds_conf_dir/log4j-solr.properties":
    ensure  => present,
    content => template('dspace/log4j-solr.properties.erb'),
  }

  # solr
  file { "$ds_solr_dir":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_solr_dir/search":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_solr_dir/search/data":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_solr_dir/oai":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }->
  file { "$ds_solr_dir/oai/data":
    ensure => directory,
    mode    => '775',
    group   => $ds_group,
  }

  # tmp
  file { "$ds_tmp_dir":
    ensure => directory,
    group   => $ds_group,
    mode    => '775',
  }
}
