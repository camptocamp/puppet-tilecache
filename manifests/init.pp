class tilecache {

  case $::osfamily {
    Debian: {
      $pkg_list = [
        'tilecache',
        'python-imaging',
        'libapache2-mod-python',
        'jpegoptim',
        'jpeginfo',
        'optipng',
        'pngcheck',
        'pngnq',
      ]
      if $::lsbdistcodename == 'lenny' {
        apache_c2c::module {'python':
          ensure  => present,
          require => Package['libapache2-mod-python'],
        }
      }
    }
    RedHat: {
      $pkg_list = [
        'python-tilecache',
        'python-imaging',
        'mod_python',
        'optipng',
      ]
      # python-tilecache is not included in RHEL, so we use a working version from
      # the Fedora repository
      case $::operatingsystemmajrelease {
        '6', '7': {
          yumrepo {'fedora-core13-for-tilecache':
            descr       => 'Fedora Core 13',
            baseurl     => 'http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/13/$basearch',
            enabled     => 1,
            gpgcheck    => 0,
            includepkgs => 'python-tilecache',
            before      => Package['python-tilecache'],
          }
        }
        default: { fail 'This version of RHEL is not supported' }
      }
    }
    default: {
      fail("Unsupported Operating System family: ${::osfamily}")
    }
  }

  package { $pkg_list:
    ensure  => present,
  }

  if defined(Class['apache_c2c']) {
    apache_c2c::module {'expires':
      ensure => present,
    }
  }
  if defined(Class['apache']) {
    include apache::mod::expires
  }

}
