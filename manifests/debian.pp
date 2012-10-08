class tilecache::debian {

  package {
    [
      "tilecache", 
      "python-imaging", 
      "libapache2-mod-python",
      "jpegoptim",
      "jpeginfo",
      "optipng",
      "pngcheck",
      "pngnq",
    ]:
    ensure  => present,
  }

  case $lsbdistcodename {
    'lenny' : {
      apache::module {"python":
        ensure  => present,
        require => Package["libapache2-mod-python"],
      }
      case $architecture {
        'amd64': {
          package {"python-image-merge":
            ensure => present,
          }
        }
      }
    }
  }

  apache::module {"expires":
    ensure => present,
  }

}
