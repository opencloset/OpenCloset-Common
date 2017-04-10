package OpenCloset::Constants::Measurement;

use utf8;
require Exporter;
@ISA = qw/Exporter/;
@EXPORT =
    qw/$HEIGHT $WEIGHT $NECK $BUST $WAIST $HIP $TOPBELLY $BELLY $THIGH $ARM $LEG $KNEE $FOOT $PANTS $SKIRT $LENGTH $CUFF $COLOR $GENDER/;
@EXPORT_OK = qw/%AVG_LEG_BY_HEIGHT %AVG_KNEE_BY_HEIGHT/;

use strict;
use warnings;

our $HEIGHT   = 'height';
our $WEIGHT   = 'weight';
our $NECK     = 'neck';
our $BUST     = 'bust';
our $WAIST    = 'waist';
our $HIP      = 'hip';
our $TOPBELLY = 'topbelly';
our $BELLY    = 'belly';
our $THIGH    = 'thigh';
our $ARM      = 'arm';
our $LEG      = 'leg';
our $KNEE     = 'knee';
our $FOOT     = 'foot';
our $PANTS    = 'pants';
our $SKIRT    = 'skirt';
our $LENGTH   = 'length';
our $CUFF     = 'cuff';

our $COLOR  = 'color';  # for clothes
our $GENDER = 'gender'; # for clothes

our @ALL = (
    $HEIGHT,   $WEIGHT, $NECK,  $BUST,   $WAIST, $HIP,
    $TOPBELLY, $BELLY,  $THIGH, $ARM,    $LEG,   $KNEE,
    $FOOT,     $PANTS,  $SKIRT, $LENGTH, $CUFF
);

our @PRIMARY = ( $HEIGHT, $WEIGHT, $NECK, $BUST, $WAIST, $TOPBELLY, $HIP, $THIGH, $ARM, $LEG, $KNEE, $FOOT );

our $LABEL_HEIGHT   = '키';
our $LABEL_WEIGHT   = '몸무게';
our $LABEL_NECK     = '목둘레';
our $LABEL_BUST     = '가슴둘레';
our $LABEL_WAIST    = '허리둘레';
our $LABEL_HIP      = '엉덩이둘레';
our $LABEL_TOPBELLY = '윗배둘레';
our $LABEL_BELLY    = '배꼽둘레';
our $LABEL_THIGH    = '허벅지둘레';
our $LABEL_ARM      = '팔길이';
our $LABEL_LEG      = '다리길이';
our $LABEL_KNEE     = '무릎길이';
our $LABEL_FOOT     = '발크기';
our $LABEL_PANTS    = '바지길이';
our $LABEL_SKIRT    = '스커트길이';
our $LABEL_LENGTH   = '길이';
our $LABEL_CUFF     = '밑단둘레';

our $LABEL_COLOR  = '색상'; # for clothes
our $LABEL_GENDER = '성별'; # for clothes

our @ALL_LABEL = (
    $LABEL_HEIGHT, $LABEL_WEIGHT, $LABEL_NECK,     $LABEL_BUST,
    $LABEL_WAIST,  $LABEL_HIP,    $LABEL_TOPBELLY, $LABEL_BELLY,
    $LABEL_THIGH,  $LABEL_ARM,    $LABEL_LEG,      $LABEL_KNEE,
    $LABEL_FOOT,   $LABEL_PANTS,  $LABEL_SKIRT,    $LABEL_LENGTH,
    $LABEL_CUFF
);

our %LABEL_MAP = (
    $HEIGHT   => $LABEL_HEIGHT,
    $WEIGHT   => $LABEL_WEIGHT,
    $NECK     => $LABEL_NECK,
    $BUST     => $LABEL_BUST,
    $WAIST    => $LABEL_WAIST,
    $HIP      => $LABEL_HIP,
    $TOPBELLY => $LABEL_TOPBELLY,
    $BELLY    => $LABEL_BELLY,
    $THIGH    => $LABEL_THIGH,
    $ARM      => $LABEL_ARM,
    $LEG      => $LABEL_LEG,
    $KNEE     => $LABEL_KNEE,
    $FOOT     => $LABEL_FOOT,
    $PANTS    => $LABEL_PANTS,
    $SKIRT    => $LABEL_SKIRT,
    $LENGTH   => $LABEL_LENGTH,
    $CUFF     => $LABEL_CUFF,
    $COLOR    => $LABEL_COLOR,
    $GENDER   => $LABEL_GENDER,
);

our %UNIT_MAP = (
    $HEIGHT   => 'cm',
    $WEIGHT   => 'kg',
    $NECK     => 'cm',
    $BUST     => 'cm',
    $WAIST    => 'cm',
    $HIP      => 'cm',
    $TOPBELLY => 'cm',
    $BELLY    => 'cm',
    $THIGH    => 'cm',
    $ARM      => 'cm',
    $LEG      => 'cm',
    $KNEE     => 'cm',
    $FOOT     => 'mm',
    $PANTS    => 'cm',
    $SKIRT    => 'cm',
    $LENGTH   => 'cm',
    $CUFF     => 'cm'
);

our %AVG_LEG_BY_HEIGHT = (
    160 => 92.6,
    161 => 92.6,
    162 => 92.6,
    163 => 92.6,
    164 => 92.6,
    165 => 92.6,

    166 => 95.2,
    167 => 95.2,
    168 => 95.2,
    169 => 95.2,
    170 => 95.2,

    171 => 97.8,
    172 => 97.8,
    173 => 97.8,
    174 => 97.8,
    175 => 97.8,

    176 => 100.6,
    177 => 100.6,
    178 => 100.6,
    179 => 100.6,
    180 => 100.6,

    181 => 103.6,
    182 => 103.6,
    183 => 103.6,
    184 => 103.6,
    185 => 103.6,

    186 => 106.9,
    187 => 106.9,
    188 => 106.9,
    189 => 106.9,
    190 => 106.9,

    191 => 110.0,
    192 => 110.0,
    193 => 110.0,
    194 => 110.0,
    195 => 110.0,

    196 => 111.0,
    197 => 111.0,
    198 => 111.0,
    199 => 111.0,
    200 => 111.0,
);

our %AVG_KNEE_BY_HEIGHT = (
    140 => 43.4,
    141 => 43.4,
    142 => 43.4,
    143 => 43.4,
    144 => 43.4,
    145 => 43.4,

    146 => 45.6,
    147 => 45.6,
    148 => 45.6,
    149 => 45.6,
    150 => 45.6,

    151 => 47.2,
    152 => 47.2,
    153 => 47.2,
    154 => 47.2,
    155 => 47.2,

    156 => 48.6,
    157 => 48.6,
    158 => 48.6,
    159 => 48.6,
    160 => 48.6,

    161 => 49.7,
    162 => 49.7,
    163 => 49.7,
    164 => 49.7,
    165 => 49.7,

    166 => 51.1,
    167 => 51.1,
    168 => 51.1,
    169 => 51.1,
    170 => 51.1,

    171 => 52.8,
    172 => 52.8,
    173 => 52.8,
    174 => 52.8,
    175 => 52.8,

    176 => 54.5,
    177 => 54.5,
    178 => 54.5,
    179 => 54.5,
    180 => 54.5,
);

1;

__END__

=encoding utf8

=head1 NAME

OpenCloset::Constants::Measurement

=head1 EXPORT

=over

=item *

C<$HEIGHT>

=item *

C<$WEIGHT>

=item *

C<$NECK>

=item *

C<$BUST>

=item *

C<$WAIST>

=item *

C<$HIP>

=item *

C<$TOPBELLY>

=item *

C<$BELLY>

=item *

C<$THIGH>

=item *

C<$ARM>

=item *

C<$LEG>

=item *

C<$KNEE>

=item *

C<$FOOT>

=item *

C<$PANTS>

=item *

C<$SKIRT>

=item *

C<$LENGTH>

=item *

C<$CUFF>

=item *

C<$COLOR>

=item *

C<$GENDER>

=back

=head1 EXPORT_OK

=over

=item *

C<%AVG_LEG_BY_HEIGHT>

=item *

C<%AVG_KNEE_BY_HEIGHT>

=back

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
