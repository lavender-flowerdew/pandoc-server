#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI::Escape;

my ($buffer, @pairs, $pair, $name, $value, %FORM, $str, $ifilename, $ofilename, $fh);

$ifilename = '/home/flower/www/req.md';
$ofilename = '/home/flower/www/out.html';

sub logit {
  my $name = shift;
  my $txt = shift;
  if (!open($fh, '>>:utf8', '/home/flower/logs/perl-fastcgi.log')) {
    open($fh, '>>:utf8', '/home/flower/logs/perl-fastcgi-index.log');
  }
  print $fh "/home/flower/www/$name: $txt";
  close $fh;
}

sub readContent {
  if ($ENV{'REQUEST_METHOD'} eq "POST"){
     read(STDIN, $str, $ENV{'CONTENT_LENGTH'});
     return uri_unescape($str);
  } else {
     $buffer = $ENV{'QUERY_STRING'};

     @pairs = split(/&/, $buffer);
     foreach $pair (@pairs) {
        ($name, $value) = split(/=/, $pair);
        $value =~ tr/+/ /;
        $value =~ s/%(..)/pack("C", hex($1))/eg;
        $FORM{$name} = $value;
     }

     $str=uri_unescape($FORM{'str'});
     return $str;
  }
}

sub createInputFile {
  my $document = shift;

  if (open(my $fh, '>:utf8', $ifilename)) {
    print $fh $document;
    close $fh;
  } else {
    logit("common.pl", "Unable to open file for processing\n");
  }
}

sub compile {
  my $format = shift;
  my $o = qx/bash -c '\/home\/flower\/bin\/pandoc --from=markdown --to=$format --output=$ofilename $ifilename'/;
  logit("common.pl", "Pandoc processing $o\n");
}

sub showFile {
  my $contentType = shift;
  binmode(STDOUT);
  print "Content-type: $contentType\n\n";

  if (open(my $fh, '<:utf8', $ofilename)) {
    while (my $row = <$fh>) {
      chomp $row;
      print "$row\n";
    }
  } else {
    logit("common.pl", "Unable to read file for processing\n");
  }
}
