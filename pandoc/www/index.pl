#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI::Escape;

my ($buffer, @pairs, $pair, $name, $value, %FORM, $cfh, $properties, $regex, $regex_builder, $str);

createInputFile(readContent());
compile();
showFile(readFile());

sub readContent {
  if ($ENV{'REQUEST_METHOD'} eq "POST"){
     read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
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
     $buffer=$str;
  }
  return $buffer;
}

sub createInputFile {
  my $texContent = shift;

  my $document = <<"END_MESSAGE";
$texContent
END_MESSAGE

  my $filename = '/home/flower/www/req.md';
  open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
  print $fh $document;
  close $fh;
}

sub compile {
  my $output = qx/\/root\/.local\/bin\/pandoc --from=markdown --to=html--output=out.html \/home\/flower\/www\/req.md/;
  return $output;
}

sub readFile {
  my $file = "/home/flower/www/out.html";
  my $pdf;

  open (my $pfh, $file);
  #binmode $pfh;
  while (<$pfh>){ $pdf .= $_; }
  close ($pfh);
  return $pdf;
}

sub showFile {
  my $pdf = shift;
  my $file = shift || "new.pdf"; # if no name is given use this
  my $method = shift || "Content-disposition:inline; filename='$file'"; default method
  my $size = length($pdf);

  print "Content-Type: application/html\n";
  print "Content-Length: $size\n";
  #print "$method\n";
  #print "Content-Transfer-Encoding: binary\n\n"; # blank line to separate headers

  print $pdf;
}
