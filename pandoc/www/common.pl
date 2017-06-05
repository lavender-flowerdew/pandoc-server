#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI::Escape;

my ($buffer, @pairs, $pair, $name, $value, %FORM, $str, $ifilename, $ofilename);

$ifilename = '/home/flower/www/req.md';
$ofilename = '/home/flower/www/out.html';

createInputFile(readContent());
compile();
showFile();

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

  open(my $fh, '>:utf8', $ifilename) or die "Could not open file '$ifilename' $!";
  print $fh $document;
  close $fh;
}

sub compile {
  qx/bash -c '\/home\/flower\/www\/pandoc --from=markdown --to=html --output=$ofilename $ifilename'/;
}

sub showFile {
  binmode(STDOUT);
  print "Content-type: text/html; charset=utf-8\n";
  print "Transfer-Encoding: inline\n\n";
  print "<html>";
  print "  <head>";
  print "    <title>Hi</title>";
  print "  </head>";
  print "  <body>";
  if (open(my $fh, '<:utf8', $ofilename)) {
    while (my $row = <$fh>) {
      chomp $row;
      print "$row\n";
    }
  } else {
    print "Not valid pandoc markdown$!";
  }
  print "  </body>";
  print "</html>";
}
