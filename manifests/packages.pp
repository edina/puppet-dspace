class dspace::packages {
  package { 'maven':
    ensure => installed,
  }
  #package { 'postgresql-server':
  #  ensure => installed,
  #}
}
