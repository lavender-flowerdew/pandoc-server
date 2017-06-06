#!/bin/bash
set -e

home=/home/flower
dir=$home/bin

if [ "$1" = 'fastcgi' ]; then
  if [ "$2" = 'start' ]; then
    shift 2
    (su - -s /bin/bash flower -c $dir/fastcgi-wrapper.pl 2>&1 | tee /home/flower/logs/fastcgi.log)
  fi

  if [ "$2" = 'stop' ]; then
    shift 2
    killall -9 fastcgi-wrapper.pl
  fi

  if [ "$2" = 'restart' ]; then
    shift 2
    killall -9 fastcgi-wrapper.pl
    (su - -s /bin/bash flower -c $dir/fastcgi-wrapper.pl 2>&1 | tee /home/flower/logs/fastcgi.log)
  fi
fi

if [ "$1" = 'pfastcgi' ]; then
  if [ "$2" = 'start' ]; then
    shift 2
    echo "Starting $dir/perl-fastcgi-wrapper.pl"
    (su - -s /bin/bash flower -c $dir/perl-fastcgi-wrapper.pl)
    echo "Started $dir/perl-fastcgi-wrapper.pl"
  fi

  if [ "$2" = 'stop' ]; then
    shift 2
    echo "Stopping perl-fastcgi-wrapper.pl"
    killall -9 perl-fastcgi-wrapper.pl
  fi

  if [ "$2" = 'restart' ]; then
    shift 2
    echo "Re-starting perl-fastcgi-wrapper.pl"
    killall -9 perl-fastcgi-wrapper.pl
    (su - -s /bin/bash flower -c $dir/perl-fastcgi-wrapper.pl 2>&1)
  fi
fi

echo "Running $@"
exec "$@"
