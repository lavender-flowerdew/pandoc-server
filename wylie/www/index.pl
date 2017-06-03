#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Config::Properties;

my ($buffer, @pairs, $pair, $name, $value, %FORM, $cfh, $properties, $regex, $regex_builder, $str);

binmode(STDOUT, ":utf8");

open $cfh, '<', '/home/flower/www/ini/c.ini' or die "unable to open property file";
$properties = Config::Properties->new();
$properties->load($cfh);

if ($ENV{'REQUEST_METHOD'} eq "POST"){
   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
   $buffer = $ENV{'QUERY_STRING'};
}

@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
   ($name, $value) = split(/=/, $pair);
   $value =~ tr/+/ /;
   $value =~ s/%(..)/pack("C", hex($1))/eg;
   $FORM{$name} = $value;
}

$str=$FORM{'str'};
#my $output = qx/date/;

my %c = $properties->properties();
my @cons = sort { length($b) <=> length($a) } keys %c;
my @rex = map { quotemeta($_) } @cons;
$regex_builder = join '|', @rex;
$regex_builder = '(' . $regex_builder . ')';
$regex = qr/$regex_builder/;
$str =~ s/$regex/$c{$1}/g;

print "Content-type:text/plain;charset=utf-8\n";
print "Content-Language: bo\n\n";
print "$str \n\n";
