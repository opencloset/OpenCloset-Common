package OpenCloset::Constants;

use utf8;
require Exporter;
@ISA = qw/Exporter/;
@EXPORT_OK =
    qw/$DEFAULT_RENTAL_PERIOD $SHIPPING_BUFFER $SHIPPING_DEADLINE_HOUR $DOES_WEAR_NULL $DOES_WEAR_YES $DOES_WEAR_MISC $DOES_WEAR_BOTH %DOES_WEAR_MAP %MAX_SUIT_TYPE_COUPON_PRICE %PAY_METHOD_MAP/;

our $DEFAULT_RENTAL_PERIOD  = 3; # 기본 대여기간 3박 4일
our $SHIPPING_BUFFER        = 2; # 배송기간은 2일
our $SHIPPING_DEADLINE_HOUR = 9; # AM 09시 까지 결제 되어야 함

our $DOES_WEAR_NULL = 0b00;
our $DOES_WEAR_YES  = 0b01;
our $DOES_WEAR_MISC = 0b10;
our $DOES_WEAR_BOTH = 0b11;

our %DOES_WEAR_MAP = (
    ''              => '안입고감',
    $DOES_WEAR_NULL => '안입고감',
    $DOES_WEAR_YES  => '입고감',
    $DOES_WEAR_MISC => '기록요망',
    $DOES_WEAR_BOTH => '입고감+기록요망'
);

our %MAX_SUIT_TYPE_COUPON_PRICE = (
    male   => 32_000,
    female => 30_000,
); # 단벌 대여 쿠폰 최대할인 금액

our %PAY_METHOD_MAP = (
    card  => '신용카드',
    trans => '실시간계좌이체',
    vbank => '가상계좌',
    phone => '휴대폰소액결제',
);

1;

__END__

=encoding utf8

=head1 NAME

OpenCloset::Constants

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
