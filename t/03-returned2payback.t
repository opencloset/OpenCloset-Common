use utf8;
use strict;
use warnings;

use open ':std', ':encoding(utf8)';
use Test::More;

use OpenCloset::Constants::Status qw/$RETURNED $PAYBACK/;
use Test::DBIx::Class {
    schema_class  => 'OpenCloset::Schema',
    connect_info  => [ 'dbi:SQLite:dbname=:memory:', '', '' ],
    connect_opts  => { quote_char => q{`}, sqlite_unicode => 1 },
    fixture_class => '::Populate',
    },
    'Order', 'OrderDetail';

use_ok( 'OpenCloset::Common::OrderStatus', qw/returned2payback/ );

my $order = Order->create(
    {
        status_id => $RETURNED,
        user_id   => 2,
    }
);

$order->create_related(
    'order_details',
    {
        clothes_code => '0J001',
        status_id    => $RETURNED,
        name         => 'J001 - 재킷',
        price        => 10_000,
        final_price  => 10_000,
        stage        => 0
    }
);

my $success = returned2payback($order);
ok( $success, 'returned2payback' );
is( $order->status_id, $PAYBACK, 'status_id' );

my $bool = 1;
my $rs = $order->order_details( { clothes_code => { '!=' => undef } } );
while ( my $row = $rs->next ) {
    $bool = $bool && $row->status_id == $PAYBACK;
}

is( $bool, 1, 'order_details status_id' );

$rs = $order->order_details( { name => '환불' } );
my $detail = $rs->next;

ok( $detail, 'order_detail 환불' );
is( $detail->price, -10000,                   'price' );
is( $detail->price, -10000,                   'final_price' );
is( $detail->desc,  '환불 수수료: 0원', '환불 수수료 default' );

## 재설정
$order->delete_related('order_details');
$order->update( { status_id => $RETURNED } );
$order->create_related(
    'order_details',
    {
        clothes_code => '0J001',
        status_id    => $RETURNED,
        name         => 'J001 - 재킷',
        price        => 10_000,
        final_price  => 10_000,
        stage        => 0
    }
);

$success = returned2payback( $order, 1_000 );
ok( $success, 'returned2payback with commision args' );

$rs = $order->order_details( { name => '환불' } );
$detail = $rs->next;

is( $detail->price, -9000,                        'price' );
is( $detail->price, -9000,                        'final_price' );
is( $detail->desc,  '환불 수수료: 1,000원', '환불 수수료 args 1,000' );

done_testing();
