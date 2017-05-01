package OpenCloset::Common::OrderStatus;

use utf8;

require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/returned2payback/;

use strict;
use warnings;
use Try::Tiny;

use OpenCloset::Constants::Status qw/$RETURNED $PAYBACK/;

=encoding utf8

=head1 NAME

OpenCloset::Common::OrderStatus - 주문서의 상태변경

=head1 DESCRIPTION

주문서의 상태를 변경

=head1 METHODS

=head2 returned2payback( $order, $commission? )

  returned2payback( $order );          # 환불수수료 0원
  returned2payback( $order, 1000 );    # 환불수수료 1000원

B<반납> 상태의 주문서를 B<환불>로 변경

C<$commission> 은 환불수수료

=over

=item *

C<$order>의 status_id 를 C<$PAYBACK> 으로 변경

=item *

C<$order-E<gt>order_details> 각 행의 status_id 를 C<$PAYBACK> 으로 변경

=item *

환불과 관련된 새로운 order_detail 행 추가

  $order->create_related('order_details', {
    stage       => 3,
    name        => '환불',
    price       => -30000,
    final_price => -30000,
    desc        => '환불 수수료: 0원',
  });

=back

=cut

sub returned2payback {
    my ( $order, $commission ) = @_;
    return unless $order;
    return if $order->status_id != $RETURNED;

    $commission //= 0;
    my $schema = $order->result_source->schema;
    my $guard  = $schema->txn_scope_guard;
    try {
        $order->update( { status_id => $PAYBACK } );
        my $price = 0;
        my $details = $order->order_details( { clothes_code => { '!=' => undef } } );
        while ( my $detail = $details->next ) {
            $price += $detail->price;
            $detail->update( { status_id => $PAYBACK } );
        }

        $order->create_related(
            'order_details',
            {
                stage       => 3,
                name        => '환불',
                price       => ( $price - $commission ) * -1,
                final_price => ( $price - $commission ) * -1,
                desc        => sprintf( "환불 수수료: %s원", commify($commission) ),
            }
        );

        $guard->commit;
        return 1;
    }
    catch {
        my $err = $_;
        print STDERR "Transaction error: $err\n";
        return;
    };
}

=head2 commify( $number )

  commify(10000);    # 10,000

=cut

sub commify {
    local $_ = shift;
    1 while s/((?:\A|[^.0-9])[-+]?\d+)(\d{3})/$1,$2/s;
    return $_;
}

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2017 열린옷장

=cut

1;

