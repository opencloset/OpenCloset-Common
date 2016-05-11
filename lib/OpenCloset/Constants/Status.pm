package OpenCloset::Constants::Status;

use utf8;
require Exporter;
@ISA       = qw/Exporter/;
@EXPORT_OK = qw/$RENTABLE $RENTAL $RENTALESS $RESERVATION $CLEANING $REPAIR $LOST $DISCARD $RETURNED $PARTIAL_RETURNED $RETURNING
    $NOT_VISITED $VISITED $RESERVATED $RETURN_RESERVATED $MEASUREMENT $SELECT $BOX $PAYMENT $FITTING_ROOM1 $FITTING_ROOM2
    $FITTING_ROOM3  $FITTING_ROOM4  $FITTING_ROOM5  $FITTING_ROOM6  $FITTING_ROOM7  $FITTING_ROOM8  $FITTING_ROOM9  $FITTING_ROOM10
    $FITTING_ROOM11 $FITTING_ROOM12 $FITTING_ROOM13 $FITTING_ROOM14 $FITTING_ROOM15 $FITTING_ROOM16 $FITTING_ROOM17 $FITTING_ROOM18
    $FITTING_ROOM19 $FITTING_ROOM20 $NOT_RENTAL $CANCEL_BOX $PAYBACK $NO_SIZE $BOXED $RECYCLE_1 $RECYCLE_2 $UNRECYCLE/;

our $RENTABLE          = 1;
our $RENTAL            = 2;
our $RENTALESS         = 3;  # FIXME
our $RESERVATION       = 4;
our $CLEANING          = 5;
our $REPAIR            = 6;
our $LOST              = 7;
our $DISCARD           = 8;
our $RETURNED          = 9;
our $PARTIAL_RETURNED  = 10;
our $RETURNING         = 11;
our $NOT_VISITED       = 12;
our $VISITED           = 13;
our $RESERVATED        = 14;
our $RETURN_RESERVATED = 15;
our $MEASUREMENT       = 16;
our $SELECT            = 17;
our $BOX               = 18;
our $PAYMENT           = 19;
our $FITTING_ROOM1     = 20;
our $FITTING_ROOM2     = 21;
our $FITTING_ROOM3     = 22;
our $FITTING_ROOM4     = 23;
our $FITTING_ROOM5     = 24;
our $FITTING_ROOM6     = 25;
our $FITTING_ROOM7     = 26;
our $FITTING_ROOM8     = 27;
our $FITTING_ROOM9     = 28;
our $FITTING_ROOM10    = 29;
our $FITTING_ROOM11    = 30;
our $FITTING_ROOM12    = 31;
our $FITTING_ROOM13    = 32;
our $FITTING_ROOM14    = 33;
our $FITTING_ROOM15    = 34;
our $FITTING_ROOM16    = 35;
our $FITTING_ROOM17    = 36;
our $FITTING_ROOM18    = 37;
our $FITTING_ROOM19    = 38;
our $FITTING_ROOM20    = 39;
our $NOT_RENTAL        = 40;
our $CANCEL_BOX        = 41;
our $PAYBACK           = 42;
our $NO_SIZE           = 43;
our $BOXED             = 44;
our $RECYCLE_1         = 45;
our $RECYCLE_2         = 46;
our $UNRECYCLE         = 47; # FIXME

our $LABEL_RENTABLE          = '대여가능';
our $LABEL_RENTAL            = '대여중';
our $LABEL_RENTALESS         = '대여불가';     # FIXME
our $LABEL_RESERVATION       = '예약';
our $LABEL_CLEANING          = '세탁';
our $LABEL_REPAIR            = '수선';
our $LABEL_LOST              = '분실';
our $LABEL_DISCARD           = '폐기';
our $LABEL_RETURNED          = '반납';
our $LABEL_PARTIAL_RETURNED  = '부분반납';
our $LABEL_RETURNING         = '반납배송중';
our $LABEL_NOT_VISITED       = '방문안함';
our $LABEL_VISITED           = '방문';
our $LABEL_RESERVATED        = '방문예약';
our $LABEL_RETURN_RESERVATED = '배송예약';
our $LABEL_MEASUREMENT       = '치수측정';
our $LABEL_SELECT            = '의류준비';
our $LABEL_BOX               = '포장';
our $LABEL_PAYMENT           = '결제대기';
our $LABEL_FITTING_ROOM1     = '탈의01';
our $LABEL_FITTING_ROOM2     = '탈의02';
our $LABEL_FITTING_ROOM3     = '탈의03';
our $LABEL_FITTING_ROOM4     = '탈의04';
our $LABEL_FITTING_ROOM5     = '탈의05';
our $LABEL_FITTING_ROOM6     = '탈의06';
our $LABEL_FITTING_ROOM7     = '탈의07';
our $LABEL_FITTING_ROOM8     = '탈의08';
our $LABEL_FITTING_ROOM9     = '탈의09';
our $LABEL_FITTING_ROOM10    = '탈의10';
our $LABEL_FITTING_ROOM11    = '탈의11';
our $LABEL_FITTING_ROOM12    = '탈의12';
our $LABEL_FITTING_ROOM13    = '탈의13';
our $LABEL_FITTING_ROOM14    = '탈의14';
our $LABEL_FITTING_ROOM15    = '탈의15';
our $LABEL_FITTING_ROOM16    = '탈의16';
our $LABEL_FITTING_ROOM17    = '탈의17';
our $LABEL_FITTING_ROOM18    = '탈의18';
our $LABEL_FITTING_ROOM19    = '탈의19';
our $LABEL_FITTING_ROOM20    = '탈의20';
our $LABEL_NOT_RENTAL        = '대여안함';
our $LABEL_CANCEL_BOX        = '포장취소';
our $LABEL_PAYBACK           = '환불';
our $LABEL_NO_SIZE           = '사이즈없음';
our $LABEL_BOXED             = '포장완료';
our $LABEL_RECYCLE_1         = '재활용(옷캔)';
our $LABEL_RECYCLE_2         = '재활용(비백)';
our $LABEL_UNRECYCLE         = '사용못함';     # FIXME

our @ALL = (
    $RENTABLE, $RENTAL, $RENTALESS, $RESERVATION, $CLEANING, $REPAIR, $LOST, $DISCARD, $RETURNED, $PARTIAL_RETURNED, $RETURNING,
    $NOT_VISITED, $VISITED, $RESERVATED, $RETURN_RESERVATED, $MEASUREMENT, $SELECT, $BOX, $PAYMENT, $FITTING_ROOM1, $FITTING_ROOM2,
    $FITTING_ROOM3,  $FITTING_ROOM4,  $FITTING_ROOM5,  $FITTING_ROOM6,  $FITTING_ROOM7,  $FITTING_ROOM8,  $FITTING_ROOM9,  $FITTING_ROOM10,
    $FITTING_ROOM11, $FITTING_ROOM12, $FITTING_ROOM13, $FITTING_ROOM14, $FITTING_ROOM15, $FITTING_ROOM16, $FITTING_ROOM17, $FITTING_ROOM18,
    $FITTING_ROOM19, $FITTING_ROOM20, $NOT_RENTAL, $CANCEL_BOX, $PAYBACK, $NO_SIZE, $BOXED, $RECYCLE_1, $RECYCLE_2, $UNRECYCLE
);

our @ALL_LABEL = (
    $LABEL_RENTABLE, $LABEL_RENTAL,           $LABEL_RENTALESS, $LABEL_RESERVATION, $LABEL_CLEANING, $LABEL_REPAIR, $LABEL_LOST, $LABEL_DISCARD,
    $LABEL_RETURNED, $LABEL_PARTIAL_RETURNED, $LABEL_RETURNING,
    $LABEL_NOT_VISITED, $LABEL_VISITED,       $LABEL_RESERVATED, $LABEL_RETURN_RESERVATED, $LABEL_MEASUREMENT, $LABEL_SELECT, $LABEL_BOX,
    $LABEL_PAYMENT,     $LABEL_FITTING_ROOM1, $LABEL_FITTING_ROOM2,
    $LABEL_FITTING_ROOM3,  $LABEL_FITTING_ROOM4,  $LABEL_FITTING_ROOM5,  $LABEL_FITTING_ROOM6,  $LABEL_FITTING_ROOM7,  $LABEL_FITTING_ROOM8,
    $LABEL_FITTING_ROOM9,  $LABEL_FITTING_ROOM10,
    $LABEL_FITTING_ROOM11, $LABEL_FITTING_ROOM12, $LABEL_FITTING_ROOM13, $LABEL_FITTING_ROOM14, $LABEL_FITTING_ROOM15, $LABEL_FITTING_ROOM16,
    $LABEL_FITTING_ROOM17, $LABEL_FITTING_ROOM18,
    $LABEL_FITTING_ROOM19, $LABEL_FITTING_ROOM20, $LABEL_NOT_RENTAL, $LABEL_CANCEL_BOX, $LABEL_PAYBACK, $LABEL_NO_SIZE, $LABEL_BOXED,
    $LABEL_RECYCLE_1,      $LABEL_RECYCLE_2,      $LABEL_UNRECYCLE
);

our %LABEL_MAP = (
    $RENTABLE          => $LABEL_RENTABLE,
    $RENTAL            => $LABEL_RENTAL,
    $RENTALESS         => $LABEL_RENTALESS,
    $RESERVATION       => $LABEL_RESERVATION,
    $CLEANING          => $LABEL_CLEANING,
    $REPAIR            => $LABEL_REPAIR,
    $LOST              => $LABEL_LOST,
    $DISCARD           => $LABEL_DISCARD,
    $RETURNED          => $LABEL_RETURNED,
    $PARTIAL_RETURNED  => $LABEL_PARTIAL_RETURNED,
    $RETURNING         => $LABEL_RETURNING,
    $NOT_VISITED       => $LABEL_NOT_VISITED,
    $VISITED           => $LABEL_VISITED,
    $RESERVATED        => $LABEL_RESERVATED,
    $RETURN_RESERVATED => $LABEL_RETURN_RESERVATED,
    $MEASUREMENT       => $LABEL_MEASUREMENT,
    $SELECT            => $LABEL_SELECT,
    $BOX               => $LABEL_BOX,
    $PAYMENT           => $LABEL_PAYMENT,
    $FITTING_ROOM1     => $LABEL_FITTING_ROOM1,
    $FITTING_ROOM2     => $LABEL_FITTING_ROOM2,
    $FITTING_ROOM3     => $LABEL_FITTING_ROOM3,
    $FITTING_ROOM4     => $LABEL_FITTING_ROOM4,
    $FITTING_ROOM5     => $LABEL_FITTING_ROOM5,
    $FITTING_ROOM6     => $LABEL_FITTING_ROOM6,
    $FITTING_ROOM7     => $LABEL_FITTING_ROOM7,
    $FITTING_ROOM8     => $LABEL_FITTING_ROOM8,
    $FITTING_ROOM9     => $LABEL_FITTING_ROOM9,
    $FITTING_ROOM10    => $LABEL_FITTING_ROOM10,
    $FITTING_ROOM11    => $LABEL_FITTING_ROOM11,
    $FITTING_ROOM12    => $LABEL_FITTING_ROOM12,
    $FITTING_ROOM13    => $LABEL_FITTING_ROOM13,
    $FITTING_ROOM14    => $LABEL_FITTING_ROOM14,
    $FITTING_ROOM15    => $LABEL_FITTING_ROOM15,
    $FITTING_ROOM16    => $LABEL_FITTING_ROOM16,
    $FITTING_ROOM17    => $LABEL_FITTING_ROOM17,
    $FITTING_ROOM18    => $LABEL_FITTING_ROOM18,
    $FITTING_ROOM19    => $LABEL_FITTING_ROOM19,
    $FITTING_ROOM20    => $LABEL_FITTING_ROOM20,
    $NOT_RENTAL        => $LABEL_NOT_RENTAL,
    $CANCEL_BOX        => $LABEL_CANCEL_BOX,
    $PAYBACK           => $LABEL_PAYBACK,
    $NO_SIZE           => $LABEL_NO_SIZE,
    $BOXED             => $LABEL_BOXED,
    $RECYCLE_1         => $LABEL_RECYCLE_1,
    $RECYCLE_2         => $LABEL_RECYCLE_2,
    $UNRECYCLE         => $LABEL_UNRECYCLE,
);

1;

__END__

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
