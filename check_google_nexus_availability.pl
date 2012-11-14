#!perl 


use strict;
use warnings;

use WWW::Mechanize;
use WebService::Prowl;

my $debug = 1;
my $api_key = '';
# Im only checking the ones I want
my $url = {
    nexus_4_8gb => 'https://play.google.com/store/devices/details?id=nexus_4_8gb',
    nexus_4_16gb => 'https://play.google.com/store/devices/details?id=nexus_4_16gb',
    nexus_10_16gb => 'https://play.google.com/store/devices/details?id=nexus_10_16gb',
};


my $mech = WWW::Mechanize->new( cookie_jar => {} );
$mech->agent_alias('Windows Mozilla');
foreach my $version (keys $url) {
    print 'URL => ' . $url->{$version} . "\n";
#    $mech->get($url->{$version}) or die;
#    my $html = $mech->content;
#    version_available($version) if ( $html =~ /agotado/i );
}

sub version_available {
    my $version = shift;
    # notify here
    my $ws = WebService::Prowl->new(apikey => $api_key);
    $ws->verify || die $ws->error();
    $ws->add(   application => "Google Nexus Notif",
                event       => $version,
                description => "Still nothing..." );
    print $version if $debug;
}
