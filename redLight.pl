#!/usr/bin/perl -w

# example: http://xmodulo.com/how-to-parse-json-string-in-perl.html
# example: http://stackoverflow.com/questions/5270225/parsing-json-with-perl

# Red Light Jenkins Parser
use strict;
use warnings;
use LWP::Simple;
use JSON qw( decode_json from_json );

my $url     = "http://china.stage.shutterfly.com:2010/view/main-beta/job/1--main_beta_servers/271/api/json?tree=building,result";
my $decoded = from_json(get($url));
# This is a Perl example of parsing a JSON object.
if ($decoded->{'building'} == 1) {
    # if we're building, flash the previous color. Find that by looking at the build before this one and check out its status (result).
    print "We are building\n";
    exit 0;
} else {
    print "We are not building\n\n";
}

if ($decoded->{'result'} eq 'SUCCESS') {
    print "GREEN Build\n\n";
} elsif ($decoded->{'result'} eq 'UNSTABLE') {
    print "YELLOW Build\n\n";
} else {
    print "RED Build\n\n";
}
# print "Was the previous build successful? " . $decoded->{'result'} . "\n\n";

