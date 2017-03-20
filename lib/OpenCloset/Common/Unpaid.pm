package OpenCloset::Common::Unpaid;

use utf8;

require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/unpaid2nonpaid unpaid2fullpaid nonpaid2fullpaid unpaid_cond unpaid_attr is_nonpaid/;

use Try::Tiny;

use OpenCloset::Constants::Status qw/$RETURNED/;

=encoding utf8

=head1 NAME

OpenCloset::Common::Unpaid - 미납금, 불납금 주문서의 상태변경

=head1 DESCRIPTION

    미납주문서: 반납(9) 상태이면서 연체/배상지 지불방법이 '미납'이고
              order_detail.stage > 0 큰게 존재하는 주문서

=head1 METHODS

=head2 unpaid2xxx

미납 -> 불납 혹은 완납

=cut

sub unpaid2xxx {
    my ( $order, $price, $pay_with ) = @_;
    return unless $order;

    return if $order->status_id != $RETURNED;
    return
        if $order->late_fee_pay_with ne '미납'
        and $order->compensation_pay_with ne '미납';
    return unless $order->order_details( { stage => { '>' => 0 } } )->count;

    $price    ||= 0;
    $pay_with ||= '';

    my $schema = $order->result_source->schema;
    #
    # stage
    #
    # - 연장: 1
    # - 배상: 2
    # - 환불: 3
    # - 불납: 4
    # - 완납: 5
    # - 부분완납: 6
    #

    #
    # 연장
    #
    my $unpaid_late_fee = 0;
    if ( $order->late_fee_pay_with eq '미납' ) {
        for my $od ( $order->order_details->search( { stage => 1 } )->all ) {
            $unpaid_late_fee += $od->final_price;
        }
    }

    #
    # 배상
    #
    my $unpaid_compensation_pay = 0;
    if ( $order->compensation_pay_with eq '미납' ) {
        for my $od ( $order->order_details->search( { stage => 2 } )->all ) {
            $unpaid_compensation_pay += $od->final_price;
        }
    }

    #
    # 미납금 = 미납 연장료 + 미납 배상료
    #
    my $unpaid = $unpaid_late_fee + $unpaid_compensation_pay;
    if ( $ENV{OPENCLOSET_DEBUG} ) {
        printf STDERR "미납금.연장료: %d\n", commify($unpaid_late_fee);
        printf STDERR "미납금.배상료: %d\n", commify($unpaid_compensation_pay);
        printf STDERR "미납금.총합: %d\n",    commify($unpaid);
    }

    #
    # 완납 / 부분완납 / 불납 구분
    #
    my $stage;
    my $od_name = q{};
    if ($price) {
        if ( $price == $unpaid ) {
            $stage   = 5;
            $od_name = '완납';
        }
        else {
            $stage   = 6;
            $od_name = '부분완납';
        }
    }
    else {
        $stage   = 4;
        $od_name = '불납';
    }

    if ( $ENV{OPENCLOSET_DEBUG} ) {
        printf STDERR "미납금.상태: %s\n",       $od_name;
        printf STDERR "미납금.지불방식: %s\n", $pay_with;
        printf STDERR "미납금.받은금액: %s\n", commify($price);
    }

    #
    # TRANSACTION:
    #
    my $guard = $schema->txn_scope_guard;
    try {
        #
        # 미납 주문서의 경우 주문서 표시 금액보다 적은 금액을 받았기 때문에
        # 실제 열린옷장에서 현재 시점 기준 받은 금액으로 맞춰주기 위해
        # 미납료 만큼을 제거하는 항목 추가
        #
        # 예)
        # 3만원 주문서에 2만원 연장료와 5만원 배상료가 나왔을 경우
        # 주문서상으로 10만원을 받은 것으로 표시되지만 실제로는 3만원만
        # 받은 상태입니다. 따라서 주문서에 -7만원을 표시해서 결과적으로
        # 3만원만을 현재 받은 것으로 계산하기 위한 항목을 추가합니다.
        #
        {
            my $od = $order->create_related(
                'order_details',
                {
                    name        => '미납금 총합',
                    price       => -($unpaid),
                    final_price => -($unpaid),
                    stage       => $stage,
                    desc        => sprintf(
                        "미납금 = 연장료 + 배상료 ( %s = %s + %s )",
                        commify($unpaid), commify($unpaid_late_fee),
                        commify($unpaid_compensation_pay),
                    ),
                }
            );

            die "failed to create a new order_detail: unpaid\n" unless $od;
        }

        #
        # 받은 금액 표시 및 완납 / 부분완납 / 불납 여부 표시
        #
        {
            my $od = $order->create_related(
                'order_details',
                {
                    name        => $od_name,
                    price       => $price,
                    final_price => $price,
                    stage       => $stage,
                    desc        => sprintf(
                        "결제방식(%s), 포기금액(%s), 미납금 중 대여자로부터 받은 최종 금액",
                        $pay_with, commify( $unpaid - $price ),
                    ),
                    pay_with => $pay_with,
                }
            );

            die "failed to create a new order_detail: final user paid\n" unless $od;
        }

        #
        # 주문서의 연장료 납부 방식 및 배상료 납부 방식 갱신
        #
        {
            my %order_params;
            if ( $order->late_fee_pay_with eq '미납' ) {
                $order_params{late_fee_pay_with} = $pay_with;
            }
            if ( $order->compensation_pay_with eq '미납' ) {
                $order_params{compensation_pay_with} = $pay_with;
            }
            $order->update( \%order_params );
        }

        $guard->commit;
        return 1;
    }
    catch {
        my $err = $_;
        print STDERR "Transaction error: $err\n";
        return;
    };
}

=head2 unpaid2nonpaid( $order )

미납 -> 불납

처리방식은 C<unpaid2fullpaid> 와 동일 하지만 C<$price> 가 C<0> 이면 불납

=cut

sub unpaid2nonpaid {
    my $order = shift;
    return unless $order;

    ## price 가 undef(or 0) 이면 불납처리됨
    return unpaid2xxx($order);
}

=head2 unpaid2fullpaid( $order, $price, $pay_with )

미납 -> 완납

=cut

sub unpaid2fullpaid {
    my ( $order, $price, $pay_with ) = @_;
    return unless $order;
    return unless $price;
    return unless $pay_with;

    return unpaid2xxx( $order, $price, $pay_with );
}

=head2 nonpaid2fullpaid( $order )

불납 -> 완납

=cut

sub nonpaid2fullpaid {
    my ( $order, $price, $pay_with ) = @_;
    return unless $order;
    return unless is_nonpaid($order);

    my $detail = $order->order_details( { stage => 1 }, { rows => 1 } )->single;
    return unless $detail;

    my $schema      = $order->result_source->schema;
    my $final_price = $detail->final_price;

    my $guard = $schema->txn_scope_guard;
    try {
        my $details = $order->order_details( { stage => 4 } );
        while ( my $detail = $details->next ) {
            my $columns = { stage => 5 };
            if ( $detail->name eq '불납' ) {
                $columns->{name}        = '완납';
                $columns->{price}       = $final_price;
                $columns->{final_price} = $final_price;
                if ($price) {
                    $columns->{price} = $columns->{final_price} = $price;
                }

                $columns->{pay_with} = $pay_with if $pay_with;
            }

            $detail->update($columns);
        }

        $guard->commit;
        return 1;
    }
    catch {
        my $err = $_;
        print STDERR "Transaction error: $err\n";
        return;
    };
}

=head2 unpaid_cond

=cut

sub unpaid_cond {
    return {
        -and => [
            'me.status_id'        => $RETURNED,
            'order_details.stage' => { '>' => 0 },
            -or                   => [
                'me.late_fee_pay_with'     => '미납',
                'me.compensation_pay_with' => '미납',
            ],
        ],
    };
}

=head2 unpaid_attr

=cut

sub unpaid_attr {
    return {
        join      => [qw/ order_details /],
        group_by  => [qw/ me.id /],
        having    => { 'sum_final_price' => { '>' => 0 } },
        '+select' => [
            {
                sum => 'order_details.final_price',
                -as => 'sum_final_price'
            },
        ],
    };
}

=head2 is_nonpaid( $order )

=cut

sub is_nonpaid {
    my $order = shift;
    return unless $order;
    return $order->order_details( { stage => 4 }, { rows => 1 } )->single;
}

=head2 commify

=cut

sub commify {
    local $_ = shift;
    1 while s/((?:\A|[^.0-9])[-+]?\d+)(\d{3})/$1,$2/s;
    return $_;
}

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut

1;
