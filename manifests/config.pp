class dspace::config {
  $conf_dir = "${dspace::dsroot}/config"
  $db_pass = hiera('db::pass')
  $ds_hostname = "$hostname"
  $ds_baseurl = hiera('ds::baseurl')
  $ds_url = $ds_baseurl
  $ds_name = hiera('ds::name')

  file { "${dspace::dsroot}":
    ensure => directory,
  }->
  file { "$conf_dir":
    ensure => directory,
  }->
  file { "$conf_dir/dspace.cfg":
    ensure  => present,
    content => template('dspace/dspace.cfg.erb'),
  }
}
