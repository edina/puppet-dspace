$ds_src     = hiera('ds::src')
$ds_runtime = hiera('ds::runtime')
$db_user    = hiera('db::user')
$db_pass    = hiera('db::pass')
$db_host    = hiera('db::host')
$db_name    = hiera('db::name')
$db_port    = hiera('db::port')
$db_url     = "jdbc:postgresql://${db_host}:${db_port}/${db_name}"

file { "$ds_src/dev.properties":
  ensure  => present,
  content => template('dspace/dev.properties.erb'),
}

include dspace::db
