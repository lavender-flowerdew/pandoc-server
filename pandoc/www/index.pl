#!/usr/bin/perl
use strict;
use warnings;
use utf8;
require "/home/flower/www/common.pl";

logit("index.pl", "Saving input to file\n");
createInputFile(readContent());

logit("index.pl", "Processing for content type $ENV{'HTTP_ACCEPT'}\n");
if ($ENV{'HTTP_ACCEPT'}) {
  if (index($ENV{'HTTP_ACCEPT'}, "text/asciidoc") != -1) {
    compile("asciidoc");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/pdf") != -1){
    compile("latex");
    toPDF();
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/pdf+beamer") != -1){
    compile("latex");
    toPDF();
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/pdf+xetex") != -1){
    compile("latex");
    toPDF();
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/pdf+xelatex") != -1){
    compile("latex");
    toPDF();
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/pdf+latex") != -1){
    compile("latex");
    toPDF();
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+commonmark") != -1){
    compile("commonmark");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+docbook") != -1){
    compile("docbook");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+docbook4") != -1){
    compile("docbook4");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+docbook5") != -1){
    compile("docbook5");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/vnd.openxmlformats-officedocument.wordprocessingml.document") != -1){
    compile("docx");
    showFile("application/vnd.openxmlformats-officedocument.wordprocessingml.document; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+dokuwiki") != -1){
    compile("dokuwiki");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/html+dzslides") != -1){
    compile("dzslides");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/html+s5") != -1){
    compile("s5");
    showFile("text/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/html+slideous") != -1){
    compile("slideous");
    showFile("text/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/html+slidy") != -1){
    compile("slidy");
    showFile("text/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/epub+zip") != -1){
    compile("epub");
    showFile("application/epub");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/epub2+zip") != -1){
    compile("epub3");
    showFile("application/epub");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/epub3+zip") != -1){
    compile("epub3");
    showFile("application/epub");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+fb2") != -1){
    compile("fb2");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+haddock") != -1){
    compile("haddock");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/html") != -1){
    compile("html5");
    showFile("application/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/html") != -1){
    compile("html5");
    showFile("text/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/xhtml+xml") != -1){
    compile("html4");
    showFile("application/xhtml+xml; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/xml") != -1){
    compile("html");
    showFile("application/html; charset=utf8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+jats") != -1){
    compile("jats");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/json") != -1){
    compile("json");
    showFile("application/json; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/latex") != -1){
    compile("latex");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown") != -1){
    compile("markdown");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+github") != -1){
    compile("markdown_github");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+mmd") != -1){
    compile("markdown_mmd");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+phpextra") != -1){
    compile("markdown_phpextra");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+strict") != -1){
    compile("markdown_strict");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+mediawiki") != -1){
    compile("mediawiki");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/muse") != -1){
    compile("muse");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/pandoc+native") != -1){
    compile("native");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/plain") != -1){
    compile("plain");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/vnd.oasis.opendocument.text") != -1){
    compile("odt");
    showFile("application/vnd.oasis.opendocument.text");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/msword") != -1){
    compile("opendocument");
    showFile("application/msword");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+opml") != -1){
    compile("opml");
    showFile("application/xml; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+rst") != -1){
    compile("rst");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/xml+tei") != -1){
    compile("tei");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "application/texinfo") != -1){
    compile("texinfo");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+textile") != -1){
    compile("textile");
    showFile("text/plain; charset=utf-8");
  } elsif (index($ENV{'HTTP_ACCEPT'}, "text/markdown+zimwiki") != -1){
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
