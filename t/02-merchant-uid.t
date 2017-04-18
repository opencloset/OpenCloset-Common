#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok( 'OpenCloset::Common::Unpaid', qw/merchant_uid/ ) }

my $uid = merchant_uid();
ok( $uid, 'merchant_uid' );
like( $uid, qr/^merchant_\d{15,16}-\w{3}$/, 'merchant_uid without prefix' );

$uid = merchant_uid( 'share-%d-', 12345 );
like( $uid, qr/^share-12345-\d{15,16}-\w{3}$/, 'merchant_uid with prefix `share-%d-` and `12345` its param' );

my $prefix = 'veryloooooooooooooongprefix';
$uid = merchant_uid($prefix);

is( $uid, undef, '$prefix should be less than 20 char due to overall iamport merchant_uid length limit(40 chr)' );

done_testing;
