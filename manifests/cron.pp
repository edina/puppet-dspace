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
  cron { stats-util-index:
    command => "${ds_bin_dir}/dspace stats-util -i",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 0
  }
  cron { stats-util-optimise:
    command => "${ds_bin_dir}/dspace stats-util -o",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 30
  }
  cron { stats-general:
    command => "${ds_bin_dir}/dspace stat-general",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 35
  }
  cron { stats-monthly:
    command => "${ds_bin_dir}/dspace stat-monthly",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 40
  }
  cron { stats-report-general:
    command => "${ds_bin_dir}/dspace stat-report-general",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 45
  }
  cron { stat-report-monthly:
    command => "${ds_bin_dir}/dspace stat-report-monthly",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 50
  }
  cron { filter-media:
    command => "${ds_bin_dir}/dspace filter-media",
    user    => "${ds_user}",
    hour    => 3,
    minute  => 0
  }
  cron { curate:
    command => "${ds_bin_dir}/dspace curate -q admin_ui",
    user    => "${ds_user}",
    hour    => 4,
    minute  => 0
  }
  cron { cleanup:
    command  => "${ds_bin_dir}/dspace cleanup",
    user     => "${ds_user}",
    minute   => 0,
    hour     => 6,
    monthday => 1,
  }
  cron { cleanup:
    command  => "${ds_bin_dir}/dspace stats-util -s",
    user     => "${ds_user}",
    minute   => 0,
    hour     => 7,
    month    => 1,
    monthday => 1,
  }
}

class dspace::cron::prime {
  $ds_bin_dir = "${dspace::dsroot}/bin"
  $ds_user = "${dspace::dsuser}"

  class { 'dspace::cron':}

  cron { generate-sitemap:
    command => "${ds_bin_dir}/dspace generate-sitemaps",
    user    => "${ds_user}",
    hour    => [0, 8, 16],
    minute  => 0
  }
  cron { doi-updater:
    command => "${ds_bin_dir}/dspace doi-organiser -u 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -s 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -r 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -d 1> /dev/null",
    user    => "${ds_user}",
    hour    => ['8-19'],
    minute  => 5
  }
  cron { sub-daily:
    command => "${ds_bin_dir}/dspace sub-daily",
    user    => "${ds_user}",
    hour    => 2,
    minute  => 0
  }
  cron { embargo-lifter:
    command => "${ds_bin_dir}/dspace embargo-lifter",
    user    => "${ds_user}",
    hour    => 5,
    minute  => 15,
  }
  cron { checker:
    command => "${ds_bin_dir}/dspace checker -l -p",
    user    => "${ds_user}",
    hour    => 4,
    minute  => 0,
    weekday => 1,
  }
  cron { checker-emailer:
    command => "${ds_bin_dir}/dspace checker-emailer -c",
    user    => "${ds_user}",
    hour    => 5,
    minute  => 0,
    weekday => 1,
  }
}
