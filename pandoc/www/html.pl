#!/usr/bin/perl
use strict;
use warnings;
require "common.pl";
my ($ifilename, $ofilename);

$ifilename = '/home/flower/www/req.md';
$ofilename = '/home/flower/www/out.html';

createInputFile(readContent());
compile();
showFile();
