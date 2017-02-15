package OpenCloset::Constants;

use utf8;
require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/$DEFAULT_RENTAL_PERIOD $SHIPPING_BUFFER %PAY_METHOD_MAP/;

our $DEFAULT_RENTAL_PERIOD = 3; # 기본 대여기간 3박 4일
our $SHIPPING_BUFFER       = 2; # 배송기간은 2일

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
