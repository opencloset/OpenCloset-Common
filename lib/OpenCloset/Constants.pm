package OpenCloset::Constants;

use utf8;
require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/$DEFAULT_RENTAL_PERIOD $SHIPPING_BUFFER $RENTAL_BUFFER $PARCEL_BUFFER/;

our $DEFAULT_RENTAL_PERIOD = 3; # 기본 대여기간 3박 4일
our $SHIPPING_BUFFER       = 3; # 4일전에 예약
our $RENTAL_BUFFER         = 1; # 착용일 하루 전부터 대여일
our $PARCEL_BUFFER         = 1; # 반납일 하루 전에 택배발송

1;

__END__

=encoding utf8

=head1 NAME

OpenCloset::Constants

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
