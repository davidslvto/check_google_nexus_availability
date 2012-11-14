#!perl 


use strict;
use warnings;

use WWW::Mechanize;

my $debug = 1;

# Im only checking the ones I want
my $url = {
    nexus_4_8gb => 'https://play.google.com/store/devices/details?id=nexus_4_8gb',
    nexus_4_16gb => 'https://play.google.com/store/devices/details?id=nexus_4_16gb',
    nexus_10_16gb => 'https://play.google.com/store/devices/details?id=nexus_10_16gb',
};


my $mech = WWW::Mechanize->new( cookie_jar => {} );
$mech->agent_alias('Windows Mozilla');
for my $version (keys $url) {
    $mech->get($url->{$version}) or die;
    my $html = $mech->content;
    version_available($version) if ( $html =~ /agotado/i );
}

sub version_available {
    my $version = shift;
    # notify here
    print $version if $debug;
}