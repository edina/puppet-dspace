class dspace::config {
  $db_url = hiera('db::url')
  $db_user = hiera('db::user')
  $db_pass = hiera('db::pass')

  $ds_conf_dir = "${dspace::dsroot}/config"
  $ds_root = $dspace::dsroot
  $ds_hostname = $fqdn
  $ds_baseurl = hiera('ds::baseurl')
  $ds_url = hiera('ds::url')
  $ds_name = hiera('ds::name')
  $ds_handleurl = hiera('ds::handleurl')

  $doi_user = hiera('doi::user')
  $doi_pass = hiera('doi::pass')
  $doi_prefix = hiera('doi::prefix')
  $doi_ns = hiera('doi::ns')

  $google_analyticskey= hiera('google::analyticskey', '')

  file { "${dspace::dsroot}":
    ensure => directory,
  }->
  file { "$ds_conf_dir":
    ensure => directory,
  }->
  file { "$ds_conf_dir/dspace.cfg":
    ensure  => present,
    content => template('dspace/dspace.cfg.erb'),
  }

  $ds_modules_conf_dir = "$ds_conf_dir/modules"
  $tomcat_port = hiera('tomcat::port')
  $oai_sorage = hiera('oai::storage')
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
}
