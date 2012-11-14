#!perl 


use strict;
use warnings;

use WWW::Mechanize;
use WebService::Prowl;

my $debug = 1;
my $api_key = '';
# Im only checking the ones I want
my $url = {
    'Nexus 4 8GB'   => 'https://play.google.com/store/devices/details?id=nexus_4_8gb',
    'Nexus 4 16GB'  => 'https://play.google.com/store/devices/details?id=nexus_4_16gb',
    'Nexus 10 16GB' => 'https://play.google.com/store/devices/details?id=nexus_10_16gb',
};


my $mech = WWW::Mechanize->new( cookie_jar => {} );
$mech->agent_alias('Windows Mozilla');
foreach my $version (keys %{$url} ) {
    print 'URL => ' . $url->{$version} . "\n" if $debug;
    $mech->get($url->{$version}) or die;
    my $html = $mech->content;
    if ( $html =~ /agotado/i ) {
        versioni_not_available($version);
    } else {
        version_available($version);
    }
}

sub version_not_available {
    my $version = shift;
    # notify here
    my $ws = WebService::Prowl->new(apikey => $api_key);
    $ws->verify || die $ws->error();
    $ws->add(   application => "Google Nexus Notif",
                event       => $version,
                description => "Still nothing..." );
    print $version . "\n" if $debug;
}

sub version_available {
    my $version = shift;
    # notify here
    my $ws = WebService::Prowl->new(apikey => $api_key);
    $ws->verify || die $ws->error();
    $ws->add(   application => "Google Nexus Notif",
                event       => $version,
                description => "IT'S ALIVE!" );
    print $version . "\n" if $debug;
}
