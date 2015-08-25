class dspace::cron {
  $ds_root    = $dspace::dsroot
  $ds_bin_dir = "${ds_root}/bin"

  cron { generate-sitemap:
    command => "${ds_bin_dir}/dspace generate-sitemaps",
    minute  => [0, 8, 16]
  }
}

class dspace::cron::prime {

}
