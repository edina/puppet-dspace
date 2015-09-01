class dspace::cron {
  $ds_bin_dir = "${dspace::dsroot}/bin"
  $ds_user = "${dspace::dsuser}"

  cron { oai-import:
    command => "${ds_bin_dir}/dspace oai import -o",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 10,
  }
  cron { index-discovery:
    command => "${ds_bin_dir}/dspace index-discovery",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 20
  }
  cron { index-discovery-optimise:
    command => "${ds_bin_dir}/dspace index-discovery -o",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 30
  }
}

class dspace::cron::prime {
  $ds_bin_dir = "${dspace::dsroot}/bin"

  cron { generate-sitemap:
    command => "${ds_bin_dir}/dspace generate-sitemaps",
    user    => "${dspace::dsuser}",
    hour    => [0, 8, 16],
    minute  => 0
  }
  cron { doi-updater:
    command => "${ds_bin_dir}/dspace  -u 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -s 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -r 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -d 1> /dev/null",
    user    => "${dspace::dsuser}",
    hour    => ['8-19'],
    minute  => 5
  }
}
