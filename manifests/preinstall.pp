$ds_src = hiera('ds::src')
$ds_runtime = hiera('ds::runtime')
$db_user = hiera('db::user')
$db_pass = hiera('db::pass')
$db_url = hiera('db::url')

file { "$ds_src/dev.properties":
  ensure  => present,
  content => template('dspace/dev.properties.erb'),
}

include dspace::db
