class dspace::db {
  $db_user = 'datashar'
  $db_name = 'datashare'

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
    }->
    class { 'postgresql::server': }

  postgresql::server::role { "$db_name":
    password_hash => postgresql_password("$db_user", hiera('db::pass')),
  }
  postgresql::server::db { "$db_name":
    user     => "$db_user",
    password => postgresql_password("$db_user", hiera('db::pass')),
  }
  postgresql::server::database_grant { "$db_user":
    privilege => 'ALL',
    db        => "$db_name",
    role      => "$db_user",
  }
}
