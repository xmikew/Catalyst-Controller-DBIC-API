use strict;
use warnings;

use lib 't/lib';

my $base = 'http://localhost';

use RestTest;
use DBICTest;
use URI;
use Test::More;
use Test::WWW::Mechanize::Catalyst 'RestTest';
use HTTP::Request::Common;
use JSON;
use Data::Dumper;

my $json = JSON->new->utf8;

my $mech = Test::WWW::Mechanize::Catalyst->new;
ok( my $schema = DBICTest->init_schema(), 'got schema' );

my $base_url = "$base/api/rest/stashedclass";

# test cd
{
    my $class = 'RestTestDB::CD';
    my $req = GET( "$base_url/$class", {}, 'Accept' => 'text/x-json');
    $mech->request($req);
    cmp_ok( $mech->status, '==', '200', "status OK" );
    my $response = $json->decode( $mech->content );
    is($response->{success}, 'true', 'success');
    is(scalar( @{$response->{list}} ), 6, 'six results');
}

# test author
{
    my $class = 'RestTestDB::Artist';
    my $req = GET( "$base_url/$class", {}, 'Accept' => 'text/x-json');
    $mech->request($req);
    cmp_ok( $mech->status, '==', '200', "status OK" );
    my $response = $json->decode( $mech->content );
    is($response->{success}, 'true', 'success');
    is(scalar( @{$response->{list}} ), 3, 'three results');
}

# test non-existent class
{
    my $class = 'Foo::Bar::Baz';
    my $req = GET( "$base_url/$class", {}, 'Accept' => 'text/x-json');
    $mech->request($req);
    cmp_ok( $mech->status, '==', '400', "status 400" );
    my $response = $json->decode( $mech->content );
    like($response->{messages}[0], qr/current_result_set.*does not pass the type constraint/, 'invalid class');
}

done_testing();
