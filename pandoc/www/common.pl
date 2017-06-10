#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI::Escape;
use HTTP::Request;
use HTTP::Response;
use File::Slurp;
use LWP::UserAgent;

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
  my $o = qx/bash -c '\/home\/flower\/bin\/pandoc -s --from=markdown --to=$format --output=$ofilename $ifilename'/;
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

sub toPDF {
  logit("common.pl", "Reading latex\n");
  my $ua = LWP::UserAgent->new;
  my $uri = "http://nginx/tex/index";
  my $req = HTTP::Request->new('POST', $uri);
  $req->header('Content-Type' => 'text/latex');
  my $resp = $ua->request($req);
  my $txt = read_file($ofilename);
  logit("common.pl", "$txt\n");
  $req->content($txt);
  logit("common.pl", "Read now sending\n");

  my $resp = $ua->request($req);
  binmode(STDOUT);
  if ($resp->is_success) {
    logit("common.pl", "Sent and have pdf\n");
    print "Content-Type: application/pdf\n";
    #print "Content-Length: $size\n";
    print "Content-disposition:inline; filename='pandoc-leanne.pdf'\n\n";
    #print "Content-Transfer-Encoding: binary\n\n";
    my $message = $resp->decoded_content;
    print "$message";
  } else {
    logit("common.pl", "Sent but no pdf $resp->message\n");
    print "Content-Type: text/plain\n\n";
    print "HTTP POST error code: ", $resp->code, "\n";
    print "HTTP POST error message: ", $resp->message, "\n";
  }
}
