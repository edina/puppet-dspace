$ds_src     = hiera('ds::src', '/root/DSpace')
$ds_runtime = hiera('ds::runtime', '/usr/local/datashare')
$db_user    = hiera('db::user', 'datashar')
$db_pass    = hiera('db::pass', 'password')
$db_host    = hiera('db::host', 'localhost')
$db_name    = hiera('db::name', 'datashar')
$db_port    = hiera('db::port', '5432')
$db_url     = "jdbc:postgresql://${db_host}:${db_port}/${db_name}"

file { "$ds_src/dev.properties":
  ensure  => present,
  content => template('dspace/dev.properties.erb'),
}

include dspace::db
