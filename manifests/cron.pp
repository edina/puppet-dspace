class dspace::cron {
}

class dspace::cron::prime {
  $ds_bin_dir = "${$dspace::dsroot}/bin"

  cron { generate-sitemap:
    command => "${ds_bin_dir}/dspace generate-sitemaps",
    hour  => [0, 8, 16],
    minute => 0
  }
}
