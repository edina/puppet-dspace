$ds_src = hiera('ds::src')
$db_user = hiera('db::user')
$db_pass = hiera('db::pass')
$db_url = hiera('db::url')

file { "$ds_src/dev.properties":
  ensure  => present,
  content => template('dspace/dev.properties.erb'),
}

include dspace::db
