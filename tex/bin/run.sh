#!/bin/bash
set -e

home=/home/flower
dir=$home/bin

if [ "$1" = 'fastcgi' ]; then
  if [ "$2" = 'start' ]; then
    shift 2
    exec su - flower -c $dir/fastcgi-wrapper.pl
  fi

  if [ "$2" = 'stop' ]; then
    shift 2
    killall -9 fastcgi-wrapper.pl
  fi

  if [ "$2" = 'restart' ]; then
    shift 2
    killall -9 fastcgi-wrapper.pl
    exec su - flower -c $dir/fastcgi-wrapper.pl
  fi
fi

if [ "$1" = 'pfastcgi' ]; then
  if [ "$2" = 'start' ]; then
    shift 2
    echo "Starting $dir/perl-fastcgi-wrapper.pl"
    (su - flower -c $dir/perl-fastcgi-wrapper.pl)
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
    (su - flower -c $dir/perl-fastcgi-wrapper.pl)
  fi
fi

echo "Running $@"
exec "$@"
