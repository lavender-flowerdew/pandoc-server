#!/usr/bin/perl

# Original author: Denis S. Filimonov
# Patched by Lewin Bormann <lbo@spheniscida.de>
# Changes (quite much):
#   - No fork()s anymore, instead "inline" execution by first reading the
#     script and then executing it using eval().
#     This should result in far superior performance with perl scripts.

use strict;
use warnings;
use FCGI;
use Socket;
use POSIX qw(setsid);
use IO::Handle;
require 'syscall.ph';

&daemonize;

my ($socket, $request, %req_params, $key);

open(my $fh, '>:utf8', '/home/flower/logs/perl-fastcgi.log') or die "Could not open file 'perl-fastcgi.log' $!";
$fh->autoflush;

#this keeps the program alive or something after exec'ing perl scripts
END() { } BEGIN() { }
*CORE::GLOBAL::exit = sub { die "fakeexit\nrc=".shift()."\n"; };
eval q{exit};
if ($@) {
    exit unless $@ =~ /^fakeexit/;
};

&main;

sub daemonize() {
    chdir '/'                 or die "Can't chdir to /: $!";
    defined(my $pid = fork)   or die "Can't fork: $!";
    exit if $pid;
    setsid                    or die "Can't start a new session: $!";
    umask 0;
}

sub main {
    print $fh "Starting on 0.0.0.0:9000\n";
    $socket = FCGI::OpenSocket( "0.0.0.0:9000", 10 ); #use IP sockets
    $request = FCGI::Request( \*STDIN, \*STDOUT, \*STDERR, \%req_params, $socket );
    if ($request) { request_loop() };
    FCGI::CloseSocket( $socket );
    close $fh;
}

sub request_loop {
    while( $request->Accept() >= 0 ) {
      print $fh "$req_params{SCRIPT_FILENAME}: Received request\n";
        #running the cgi app
        if ( (-x $req_params{SCRIPT_FILENAME}) &&  #can I execute this?
            (-s $req_params{SCRIPT_FILENAME}) &&  #Is this file empty?
            (-r $req_params{SCRIPT_FILENAME})     #can I read this file?
        ){
            foreach $key ( keys %req_params){
                $ENV{$key} = $req_params{$key};
            }
            my $script_content;
            open(SCRIPT,"<",$req_params{SCRIPT_FILENAME});
            {
                local $/;
                $script_content = <SCRIPT>;
            }
            close(SCRIPT);
            print $fh "$req_params{SCRIPT_FILENAME}: Running...\n" if $@;
            my $result = eval($script_content);
            if ($@) {
              print $fh "$req_params{SCRIPT_FILENAME}: Completed with failure $@.\n";
              print("Content-type: text/plain\n\n");
              print "Error: CGI app failed - $req_params{SCRIPT_FILENAME} caused";
              print "$@";
            } else {
              print $fh "$req_params{SCRIPT_FILENAME}: Completed successfully with $result.\n";
            }

            unless(defined($result)) {
              print $fh "$req_params{SCRIPT_FILENAME}: Completed with no output\n";
              print("Content-type: text/plain\n\n");
              print "Error: CGI app returned no output - ";
              print "Executing $req_params{SCRIPT_FILENAME} failed !\n";
              print $fh "$req_params{SCRIPT_FILENAME}: Done.\n" if $@;
              next;
            }
        }
        else {
          print $fh "$req_params{SCRIPT_FILENAME}: Not runnable\n";
          print("Content-type: text/plain\n\n");
          print "Error: No such CGI app - $req_params{SCRIPT_FILENAME} may not ";
          print "exist or is not executable by this process.\n";
        }

    }
}
