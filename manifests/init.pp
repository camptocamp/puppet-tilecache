class tilecache {
  case $operatingsystem {
    Debian:  { include tilecache::debian }
    RedHat:  { include tilecache::redhat }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
