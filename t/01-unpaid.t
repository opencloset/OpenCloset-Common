use utf8;
use strict;
use warnings;

use open ':std', ':encoding(utf8)';
use Test::More;

use OpenCloset::Constants::Status qw/$RETURNED/;
use Test::DBIx::Class {
    schema_class => 'OpenCloset::Schema',
    connect_info => [ 'dbi:SQLite:dbname=:memory:', '', '' ],
    connect_opts  => { quote_char => q{`}, },
    fixture_class => '::Populate',
    },
    'Order', 'OrderDetail';

use_ok( 'OpenCloset::Common::Unpaid', qw/unpaid_cond unpaid_attr unpaid2nonpaid unpaid2fullpaid nonpaid2fullpaid is_nonpaid/ );

our $TIMEZONE = 'Asia/Seoul';

my $cond = unpaid_cond();
my $attr = unpaid_attr();

is( $cond->{'-and'}[0], 'me.status_id', 'unpaid_cond' );
is( $cond->{'-and'}[1], $RETURNED,      'unpaid_cond' );

is_deeply( $attr->{join}, [qw/order_details/], 'unpaid_attr' );

my ( $order, $detail );
$order = Order->create(
    {
        status_id             => $RETURNED,
        user_id               => 2,
        late_fee_pay_with     => '미납',
        compensation_pay_with => '미납',
    }
);

$detail = $order->create_related(
    'order_details',
    {
        name        => '연체료',
        price       => 6000,
        final_price => 6000,
        stage       => 1,
        desc        => '20,000원 x 30% x 15일'
    }
);

ok( $order,                   'order->new' );
ok( $detail,                  'order_detail->new' );
ok( unpaid2nonpaid($order),   '미납 -> 불납' );
ok( is_nonpaid($order),       '미납 -> 불납' );
ok( nonpaid2fullpaid($order), '불납 -> 완납' );

$order = Order->create(
    {
        status_id             => $RETURNED,
        user_id               => 2,
        late_fee_pay_with     => '미납',
        compensation_pay_with => '미납',
    }
);

$order->create_related(
    'order_details',
    {
        name        => '연체료',
        price       => 6000,
        final_price => 6000,
        stage       => 1,
        desc        => '20,000원 x 30% x 15일'
    }
);

ok( !unpaid2fullpaid($order), '미납 -> 완납 without price and pay_with' );
ok( !unpaid2fullpaid( $order, 6000 ), '미납 -> 완납 without pay_with' );
ok( unpaid2fullpaid( $order, 6000, '현금' ), '미납 -> 완납' );

done_testing();
