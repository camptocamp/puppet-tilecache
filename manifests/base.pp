class tilecache::base {

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
    }
  }

  apache::module {"expires":
    ensure => present,
  }

}
