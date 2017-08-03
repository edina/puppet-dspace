class dspace::db {
  $db_user = 'datashar'
  $db_name = 'datashare'

  class { 'postgresql::globals':
    version             => '9.3',
    manage_package_repo => false,
    manage_pg_hba_conf => false,
    manage_pg_ident_conf => false,
    }->
    class {"postgresql::server":
      service_name => 'postgresql-9.3'
    }

  postgresql::server::role { "$db_name":
    password_hash => postgresql_password("$db_user", hiera('db::pass', 'password')),
  }
  postgresql::server::db { "$db_name":
    user     => "$db_user",
    password => postgresql_password("$db_user", hiera('db::pass', 'password')),
  }
  postgresql::server::database_grant { "$db_user":
    privilege => 'ALL',
    db        => "$db_name",
    role      => "$db_user",
  }
}
