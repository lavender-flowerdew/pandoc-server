#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Time::Piece;
use Time::Seconds;

binmode(STDOUT, ":utf8");

my $t = localtime;
$t += ONE_DAY * 14;

print "Content-type:text/plain;charset=utf-8\n";
print "Content-Language: en\n\n";
print $t->strftime('%Y %m %d %X');
