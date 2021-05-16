package OpenCloset::Constants;

use utf8;
require Exporter;
@ISA = qw/Exporter/;
@EXPORT_OK =
    qw/$DEFAULT_RENTAL_PERIOD $SHIPPING_BUFFER $SHIPPING_DEADLINE_HOUR $MAX_EXTENSION_DAYS $DOES_WEAR_NULL $DOES_WEAR_YES $DOES_WEAR_MISC $DOES_WEAR_KEEP $MONITOR_TTS_TO_INDEX $MONITOR_TTS_TO_ROOM %DOES_WEAR_MAP %MAX_SUIT_TYPE_COUPON_PRICE %PAY_METHOD_MAP/;

our $DEFAULT_RENTAL_PERIOD  = 3;  # 기본 대여기간 3박 4일
our $SHIPPING_BUFFER        = 2;  # 배송기간은 2일
our $SHIPPING_DEADLINE_HOUR = 9;  # AM 09시 까지 결제 되어야 함
our $MAX_EXTENSION_DAYS     = 26; # 대여기간 포함 30일까지 대여가능

our $DOES_WEAR_NULL   = 0b00;
our $DOES_WEAR_YES    = 0b01;
our $DOES_WEAR_MISC   = 0b10;
our $DOES_WEAR_KEEP   = 0b11;
our $DOES_WEAR_ONLINE = 0b100;

our $MONITOR_TTS_TO_INDEX = 1;
our $MONITOR_TTS_TO_ROOM  = 2;

our %DOES_WEAR_MAP = (
    ''                => '안입고감',
    $DOES_WEAR_NULL   => '안입고감',
    $DOES_WEAR_YES    => '입고감',
    $DOES_WEAR_MISC   => '기록요망',
    $DOES_WEAR_KEEP   => '보관요망',
    $DOES_WEAR_ONLINE => '온라인예정'
);

our %MAX_SUIT_TYPE_COUPON_PRICE = (
    male   => 32_000,
    female => 30_000,
); # 단벌 대여 쿠폰 최대할인 금액

our %PAY_METHOD_MAP = (
    card         => '신용카드',
    trans        => '실시간계좌이체',
    vbank        => '가상계좌',
    phone        => '휴대폰소액결제',
    samsung      => '삼성페이',
    kpay         => 'kpay',
    kakaopay     => '카카오페이',
    payco        => '페이코',
    lpay         => 'LPAY',
    ssgpay       => 'SSG페이',
    tosspay      => '토스페이',
    cultureland  => '문화상품권',
    smartculture => '스마트문상',
    happymoney   => '해피머니',
    booknlife    => '도서문화상품권',
    point        => '포인트결제',
    coupon       => '쿠폰',
);

1;

__END__

=encoding utf8

=head1 NAME

OpenCloset::Constants

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2020 열린옷장

=cut
