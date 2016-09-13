package OpenCloset::Constants::Category;

use utf8;
require Exporter;
@ISA    = qw/Exporter/;
@EXPORT = qw/$BELT $BLOUSE $COAT $JACKET $ONEPIECE $PANTS $SHIRT $SHOES $SKIRT $TIE $WAISTCOAT $MISC/;
@EXPORT_OK =
    qw/%LABEL_MAP %REVERSE_MAP %PRICE $LABEL_BELT $LABEL_BLOUSE $LABEL_COAT $LABEL_JACKET $LABEL_ONEPIECE $LABEL_PANTS $LABEL_SHIRT $LABEL_SHOES $LABEL_SKIRT $LABEL_TIE $LABEL_WAISTCOAT $LABEL_MISC/;

our $BELT      = 'belt';
our $BLOUSE    = 'blouse';
our $COAT      = 'coat';
our $JACKET    = 'jacket';
our $ONEPIECE  = 'onepiece';
our $PANTS     = 'pants';
our $SHIRT     = 'shirt';
our $SHOES     = 'shoes';
our $SKIRT     = 'skirt';
our $TIE       = 'tie';
our $WAISTCOAT = 'waistcoat';
our $MISC      = 'misc';

our $LABEL_BELT      = '벨트';
our $LABEL_BLOUSE    = '블라우스';
our $LABEL_COAT      = '코트';
our $LABEL_JACKET    = '자켓';
our $LABEL_ONEPIECE  = '원피스';
our $LABEL_PANTS     = '팬츠';
our $LABEL_SHIRT     = '셔츠';
our $LABEL_SHOES     = '구두';
our $LABEL_SKIRT     = '스커트';
our $LABEL_TIE       = '타이';
our $LABEL_WAISTCOAT = '조끼';
our $LABEL_MISC      = '기타';

our @ALL = (
    $BELT,  $BLOUSE, $COAT,  $JACKET, $ONEPIECE,  $PANTS,
    $SHIRT, $SHOES,  $SKIRT, $TIE,    $WAISTCOAT, $MISC
);

our @ALL_LABEL = (
    $LABEL_BELT,     $LABEL_BLOUSE, $LABEL_COAT,      $LABEL_JACKET,
    $LABEL_ONEPIECE, $LABEL_PANTS,  $LABEL_SHIRT,     $LABEL_SHOES,
    $LABEL_SKIRT,    $LABEL_TIE,    $LABEL_WAISTCOAT, $LABEL_MISC
);

our %LABEL_MAP = (
    $BELT      => $LABEL_BELT,
    $BLOUSE    => $LABEL_BLOUSE,
    $COAT      => $LABEL_COAT,
    $JACKET    => $LABEL_JACKET,
    $ONEPIECE  => $LABEL_ONEPIECE,
    $PANTS     => $LABEL_PANTS,
    $SHIRT     => $LABEL_SHIRT,
    $SHOES     => $LABEL_SHOES,
    $SKIRT     => $LABEL_SKIRT,
    $TIE       => $LABEL_TIE,
    $WAISTCOAT => $LABEL_WAISTCOAT,
    $MISC      => $LABEL_MISC,
);

our %REVERSE_MAP = reverse %LABEL_MAP;

our %PRICE = (
    $BELT      => 2000,
    $BLOUSE    => 5000,
    $COAT      => 10000,
    $JACKET    => 10000,
    $ONEPIECE  => 10000,
    $PANTS     => 10000,
    $SHIRT     => 5000,
    $SHOES     => 5000,
    $SKIRT     => 10000,
    $TIE       => 0,
    $WAISTCOAT => 5000,
    $MISC      => 0,
);

1;

__END__

=encoding utf8

=head1 NAME

OpenCloset::Constants::Category

=head1 EXPORT

=over

=item $BELT

=item $BLOUSE

=item $COAT

=item $JACKET

=item $ONEPIECE

=item $PANTS

=item $SHIRT

=item $SHOES

=item $SKIRT

=item $TIE

=item $WAISTCOAT

=item $MISC

=back

=head1 EXPORT_OK

=over

=item %LABEL_MAP

=item %REVERSE_MAP

=item %PRICE

=item $LABEL_BELT

=item $LABEL_BLOUSE

=item $LABEL_COAT

=item $LABEL_JACKET

=item $LABEL_ONEPIECE

=item $LABEL_PANTS

=item $LABEL_SHIRT

=item $LABEL_SHOES

=item $LABEL_SKIRT

=item $LABEL_TIE

=item $LABEL_WAISTCOAT

=item $LABEL_MISC

=back

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
