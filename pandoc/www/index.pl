#!/usr/bin/perl
use strict;
use warnings;
use utf8;
require "/home/flower/www/common.pl";

logit("index.pl", "Saving input to file\n");
createInputFile(readContent());

logit("index.pl", "Processing for content type $ENV{'HTTP_ACCEPT'}\n");
if ($ENV{'HTTP_ACCEPT'}) {
  if ($ENV{'HTTP_ACCEPT'} eq "text/asciidoc"){
    compile("asciidoc");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/pdf"){
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/pdf+beamer"){
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/pdf+xetex"){
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/pdf+xelatex"){
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/pdf+latex"){
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+commonmark"){
    compile("commonmark");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+docbook"){
    compile("docbook");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+docbook4"){
    compile("docbook4");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+docbook5"){
    compile("docbook5");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/vnd.openxmlformats-officedocument.wordprocessingml.document"){
    compile("docx");
    showFile("application/vnd.openxmlformats-officedocument.wordprocessingml.document; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+dokuwiki"){
    compile("dokuwiki");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/html+dzslides"){
    compile("dzslides");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/html+s5"){
    compile("s5");
    showFile("text/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/html+slideous"){
    compile("slideous");
    showFile("text/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/html+slidy"){
    compile("slidy");
    showFile("text/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/epub+zip"){
    compile("epub");
    showFile("application/epub");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/epub2+zip"){
    compile("epub3");
    showFile("application/epub");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/epub3+zip"){
    compile("epub3");
    showFile("application/epub");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+fb2"){
    compile("fb2");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+haddock"){
    compile("haddock");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/html"){
    compile("html5");
    showFile("application/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/html"){
    compile("html5");
    showFile("text/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/xhtml+xml"){
    compile("html4");
    showFile("application/xhtml+xml; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/xml"){
    compile("html");
    showFile("application/html; charset=utf8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+jats"){
    compile("jats");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/json"){
    compile("json");
    showFile("application/json; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/latex"){
    compile("latex");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown"){
    compile("markdown");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+github"){
    compile("markdown_github");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+mmd"){
    compile("markdown_mmd");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+phpextra"){
    compile("markdown_phpextra");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+strict"){
    compile("markdown_strict");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+mediawiki"){
    compile("mediawiki");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/muse"){
    compile("muse");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/pandoc+native"){
    compile("native");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/plain"){
    compile("plain");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/vnd.oasis.opendocument.text"){
    compile("odt");
    showFile("application/vnd.oasis.opendocument.text");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/msword"){
    compile("opendocument");
    showFile("application/msword");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+opml"){
    compile("opml");
    showFile("application/xml; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+rst"){
    compile("rst");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/xml+tei"){
    compile("tei");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "application/texinfo"){
    compile("texinfo");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+textile"){
    compile("textile");
    showFile("text/plain; charset=utf-8");
  } elsif ($ENV{'HTTP_ACCEPT'} eq "text/markdown+zimwiki"){
    compile("zimwiki");
    showFile("text/plain; charset=utf-8");
  } else {
    compile("html");
    showFile("text/html; charset=utf8");
  }
} else {
  compile("html");
  showFile("text/html; charset=utf8");
}
logit("index.pl", "Done\n");
