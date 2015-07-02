class dspace::users {
  exec { "install_drupal":
    command => "/usr/local/bin/drush site-install standard --account-pass=${admin_pass} --db-url=${db_url} --yes",
    unless => "/usr/local/bin/drush core-status | grep 'Drupal bootstrap.*Successful'",
  }
}
