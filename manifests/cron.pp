class dspace::cron {
  $ds_bin_dir = "${dspace::dsroot}/bin"
  $ds_user = "${dspace::dsuser}"

  cron { oai-import:
    command => "${ds_bin_dir}/dspace oai import -o 1> /dev/null",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 10,
  }
  cron { generate-sitemap:
    command => "${ds_bin_dir}/dspace generate-sitemaps 1> /dev/null",
    user    => "${ds_user}",
    hour    => [0, 8, 16],
    minute  => 0
  }
  cron { index-discovery:
    command => "${ds_bin_dir}/dspace index-discovery 1> /dev/null",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 20
  }
  cron { index-discovery-optimise:
    command => "${ds_bin_dir}/dspace index-discovery -o 1> /dev/null",
    user    => "${ds_user}",
    hour    => 0,
    minute  => 30
  }
  cron { stats-util-index:
    command => "${ds_bin_dir}/dspace stats-util -i 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 0
  }
  cron { stats-util-optimise:
    command => "${ds_bin_dir}/dspace stats-util -o 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 30
  }
  cron { stats-general:
    command => "${ds_bin_dir}/dspace stat-general 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 35
  }
  cron { stats-monthly:
    command => "${ds_bin_dir}/dspace stat-monthly 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 40
  }
  cron { stats-report-general:
    command => "${ds_bin_dir}/dspace stat-report-general 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 45
  }
  cron { stat-report-monthly:
    command => "${ds_bin_dir}/dspace stat-report-monthly 1> /dev/null",
    user    => "${ds_user}",
    hour    => 1,
    minute  => 50
  }
  cron { curate:
    command => "${ds_bin_dir}/dspace curate -q admin_ui 1> /dev/null",
    user    => "${ds_user}",
    hour    => 4,
    minute  => 0
  }
  cron { cleanup:
    command  => "${ds_bin_dir}/dspace cleanup 1> /dev/null",
    user     => "${ds_user}",
    minute   => 0,
    hour     => 6,
    monthday => 1,
  }
  cron { stats-cleanup:
    command  => "${ds_bin_dir}/dspace stats-util -s",
    user     => "${ds_user}",
    minute   => 0,
    hour     => 7,
    month    => 1,
    monthday => 1,
  }
}

class dspace::cron::beta {
  $ds_bin_dir = "${dspace::dsroot}/bin"
  $ds_user = "${dspace::dsuser}"
  $ds_fmoptions = hiera('ds::fmoptions')

  class { 'dspace::cron':}

  # enable when live
  cron { doi-updater:
    command => "${ds_bin_dir}/dspace doi-organiser -u 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -s 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -r 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -d 1> /dev/null",
    user    => "${ds_user}",
    hour    => ['8-19'],
    minute  => 5
  }
  cron { embargo-lifter:
    command => "${ds_bin_dir}/dspace embargo-lifter 1> /dev/null",
    user    => "${ds_user}",
    hour    => 5,
    minute  => 15,
  }
  cron { filter-media:
    command => "${ds_bin_dir}/dspace filter-media $ds_fmoptions 1> /dev/null",
    user    => "${ds_user}",
    hour    => 3,
    minute  => 0
  }
  cron { monitoring-live:
    command => "/home/datashare/bin/monitor-datashare.sh LIVE 1> ${ds_bin_dir}/test.out",
    user    => "${ds_user}",
    minute  => '*/20'
  }
}

class dspace::cron::prime {
  $ds_bin_dir = "${dspace::dsroot}/bin"
  $ds_user = "${dspace::dsuser}"
  $ds_fmoptions = hiera('ds::fmoptions')

  class { 'dspace::cron':}

  cron { doi-updater:
    command => "${ds_bin_dir}/dspace doi-organiser -u 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -s 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -r 1> /dev/null ; ${ds_bin_dir}/dspace doi-organiser -d 1> /dev/null",
    user    => "${ds_user}",
    hour    => ['8-19'],
    minute  => 5
  }
  cron { sub-daily:
    command => "${ds_bin_dir}/dspace sub-daily 1> /dev/null",
    user    => "${ds_user}",
    hour    => 2,
    minute  => 0
  }
  cron { embargo-lifter:
    command => "${ds_bin_dir}/dspace embargo-lifter 1> /dev/null",
    user    => "${ds_user}",
    hour    => 5,
    minute  => 15,
  }
  cron { checker:
    command => "${ds_bin_dir}/dspace checker -l -p 1> /dev/null",
    user    => "${ds_user}",
    hour    => 4,
    minute  => 0,
    weekday => 1,
  }
  cron { checker-emailer:
    command => "${ds_bin_dir}/dspace checker-emailer -c 1> /dev/null",
    user    => "${ds_user}",
    hour    => 5,
    minute  => 0,
    weekday => 1,
  }
  cron { filter-media:
    command => "${ds_bin_dir}/dspace filter-media $ds_fmoptions 1> /dev/null",
    user    => "${ds_user}",
    hour    => 3,
    minute  => 0
  }
}
