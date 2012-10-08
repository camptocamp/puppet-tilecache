class tilecache::redhat {

  package {
    [
      "python-tilecache",
      "python-imaging",
      "mod_python",
      "optipng",
    ]:
    ensure  => present,
  }

  # python-tilecache is not included in RHEL, so we use a working version from
  # the Fedora repository
  if $lsbdistid == 'RedHatEnterpriseServer' {
    case $lsbmajdistrelease {
      '6': {
        yumrepo {'fedora-core13-for-tilecache':
          descr       => 'Fedora Core 13',
          baseurl     => 'http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/13/$basearch',
          enabled     => 1,
          gpgcheck    => 0,
          includepkgs => 'python-tilecache',
          before      => Package['python-tilecache'],
        }
      }
      default: { fail "This version of RHEL not supported in tilecache::redhat" }
    }
  }

  apache::module {"expires":
    ensure => present,
  }

}
