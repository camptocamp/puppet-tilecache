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
      apache_c2c::module {"python":
        ensure  => present,
        require => Package["libapache2-mod-python"],
      }
    }
  }

  apache_c2c::module {"expires":
    ensure => present,
  }

}
