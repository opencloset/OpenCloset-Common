package OpenCloset::Clothes;

=encoding utf8

=head1 NAME

OpenCloset::Clothes - clothes funtions and so..

=head1 SYNOPSIS

    my $clothes    = OpenCloset::Clothes->new(clothes => $clothes);
    my $suggestion = $clothes->suggest_repair_size;
    # {
    #   bust  => 87,
    #   waist => 78
    #   ...
    # }

=cut

use utf8;
use Moo;
use Mojo::Log;

use OpenCloset::Constants::Category;

our %WAIST_THIGH_MAP = (
    78  => 58,
    80  => 60,
    82  => 62,
    84  => 64,
    86  => 64,
    88  => 66,
    90  => 68,
    92  => 68,
    94  => 70,
    96  => 70,
    98  => 70,
    100 => 72,
    102 => 72,
    104 => 72,
    106 => 74,
    108 => 74,
    110 => 76,
    112 => 76,
    114 => 78,
    116 => 78,
    118 => 80,

    ## aanoaa's custom
    79  => 59,
    81  => 61,
    83  => 63,
    85  => 64,
    87  => 65,
    89  => 67,
    91  => 68,
    93  => 69,
    95  => 70,
    97  => 70,
    99  => 71,
    101 => 72,
    103 => 72,
    105 => 73,
    107 => 74,
    109 => 75,
    111 => 76,
    113 => 77,
    115 => 78,
    117 => 79,
    119 => 80,
);

our %WAIST_CUFF_MAP = (
    78  => 7,
    80  => 7,
    82  => 7.25,
    84  => 7.25,
    86  => 7.25,
    88  => 7.50,
    90  => 7.50,
    92  => 7.50,
    94  => 7.50,
    96  => 7.75,
    98  => 7.75,
    100 => 7.75,
    102 => 8,
    104 => 8,
    106 => 8,
    108 => 8.25,
    110 => 8.25,
    112 => 8.25,
    114 => 8.50,
    116 => 8.50,
    118 => 8.50,

    ## aanoaa's custom
    79  => 7,
    81  => 7,
    83  => 7.25,
    85  => 7.25,
    87  => 7.25,
    89  => 7.50,
    91  => 7.50,
    93  => 7.50,
    95  => 7.50,
    97  => 7.75,
    99  => 7.75,
    101 => 7.75,
    103 => 8,
    105 => 8,
    107 => 8,
    109 => 8.25,
    111 => 8.25,
    113 => 8.25,
    115 => 8.50,
    117 => 8.50,
    119 => 8.50,
);

our %HIP_WAIST_MAP = (
    82  => 59,
    84  => 60,
    86  => 64,
    88  => 66,
    90  => 68,
    92  => 70,
    94  => 72,
    96  => 74,
    98  => 76,
    100 => 78,
    102 => 80,
    104 => 84,
    106 => 86,
    108 => 88,
    110 => 90,
    112 => 92,
    114 => 94,

    ## aanoaa's custom
    83  => 59,
    85  => 62,
    87  => 65,
    89  => 67,
    91  => 69,
    93  => 71,
    95  => 73,
    97  => 75,
    99  => 77,
    101 => 79,
    103 => 82,
    105 => 85,
    107 => 87,
    109 => 89,
    111 => 91,
    113 => 93,
    115 => 95,
);

our %HIP_LENGTH_MAP = (
    82  => 46,
    84  => 46,
    86  => 48,
    88  => 48,
    90  => 51,
    92  => 51,
    94  => 51,
    96  => 52,
    98  => 52,
    100 => 52,
    102 => 52,
    104 => 53,
    106 => 53,
    108 => 53,
    110 => 53,
    112 => 53,
    114 => 53,

    ## aanoaa's custom
    83  => 46,
    85  => 47,
    87  => 48,
    89  => 50,
    91  => 51,
    93  => 51,
    95  => 51,
    97  => 52,
    99  => 52,
    101 => 52,
    103 => 52,
    105 => 53,
    107 => 53,
    109 => 53,
    111 => 53,
    113 => 53,
    115 => 54,
);

our %TOPBELLY_ARM_MAP;
map { $TOPBELLY_ARM_MAP{$_} = 56 } ( 50 .. 62 );  # aanoaa's custom
map { $TOPBELLY_ARM_MAP{$_} = 56 } ( 62 .. 68 );
map { $TOPBELLY_ARM_MAP{$_} = 58 } ( 69 .. 100 ); # aanoaa's custom

our %LENGTH_ARM_MAP = (
    60 => 50,
    62 => 51,
    64 => 52,
    66 => 53,
    68 => 54,
    70 => 56,
    72 => 58,
    74 => 60,
    76 => 61,
    78 => 62,
    80 => 64,
    82 => 66,
    84 => 67,
    86 => 68,
    88 => 69,
    90 => 70,

    ## aanoaa's custom
    61 => 50,
    63 => 51,
    65 => 52,
    67 => 53,
    69 => 55,
    71 => 57,
    73 => 59,
    75 => 60,
    77 => 61,
    79 => 63,
    81 => 65,
    83 => 66,
    85 => 67,
    87 => 68,
    89 => 69,
);

has clothes => ( is => 'ro', required => 1 );
has rs      => ( is => 'ro', default  => sub { shift->clothes } );
has log     => ( is => 'ro', default  => sub { Mojo::Log->new } );

=head1 METHODS

=head2 suggest_repair_size

    my $suggestion = $clothes->suggest_repair_size;
    # {
    #   bust  => 95
    #   waist => 78,
    # }

=cut

sub suggest_repair_size {
    my ( $self, $opts ) = @_;

    my $rs       = $self->rs;
    my $code     = $rs->code;
    my $category = $rs->category;
    my $gender   = $rs->gender || '';
    my ( $top, $bottom );

    $self->log->debug("code: $code");
    $self->log->debug("category: $category");
    $self->log->debug("gender: $gender");

    if ( "$PANTS $SKIRT" =~ m/\b$category\b/ ) {
        my $suit = $rs->suit_code_bottom;
        $top = $suit->code_top if $suit;
        $bottom = $rs;
    }
    else {
        $self->log->debug("Not supported category: $category");
        return;
    }

    my $bust     = $top    ? $top->bust     || 0 : 0;
    my $topbelly = $top    ? $top->topbelly || 0 : 0;
    my $waist    = $bottom ? $bottom->waist || 0 : 0;
    my $deviation = $topbelly - $waist;
    my $hip       = $bottom ? $bottom->hip || 0 : 0;
    my $thigh     = $bottom ? $bottom->thigh || 0 : 0;
    my $cuff      = $bottom ? $bottom->cuff || 0 : 0;

    $self->log->debug("topbelly: $topbelly") if $topbelly;
    $self->log->debug("waist: $waist")       if $waist;
    $self->log->debug("hip: $hip")           if $hip;
    $self->log->debug("thigh: $thigh")       if $thigh;
    $self->log->debug("cuff: $cuff")         if $cuff;

    my $stretch = 0;
    $stretch += $opts->{stretch} if $opts->{stretch};
    if ( $opts->{has_dual_tuck} ) {
        $stretch += 8;
    }
    elsif ( $opts->{has_tuck} ) {
        $stretch += 4;
    }

    my ( %bottom,      %top );
    my ( @bottom_desc, @top_desc );
    my $done;
    use experimental 'switch';
    given ($category) {
        when (/$PANTS/) {
            break if $gender eq 'female';

            $self->log->on(
                message => sub {
                    my ( $log, $level, @lines ) = @_;
                    push @bottom_desc, @lines;
                }
            );

            $self->log->debug( sprintf "윗배 - 허리: %scm", $deviation );

            if ( $deviation < 0 ) {
                $self->log->debug("허리가 윗배보다 크거나 셋트의류가 아님");
                $bottom{thigh} = $WAIST_THIGH_MAP{$waist};
                $bottom{cuff}  = $WAIST_CUFF_MAP{$waist};
                $self->log->debug('[수선] 허벅지');
                $self->log->debug('[수선] 밑단');
                $done = 1;
            }
            elsif ( $deviation >= 5 && $deviation <= 8 ) {
                $bottom{thigh} = $WAIST_THIGH_MAP{$waist};
                $bottom{cuff}  = $WAIST_CUFF_MAP{$waist};
                $self->log->debug('[수선] 허벅지');
                $self->log->debug('[수선] 밑단');
                $done = 1;
            }
            elsif ( $deviation > 8 ) {
                $self->log->debug( sprintf "+%scm 허리늘임 가능", $stretch );

                my $expected_waist = $topbelly - 9;
                if ( $waist + $stretch >= $expected_waist ) {
                    $bottom{waist} = $expected_waist;
                    $bottom{thigh} = $WAIST_THIGH_MAP{ $bottom{waist} };
                    $bottom{cuff}  = $WAIST_CUFF_MAP{ $bottom{waist} };
                    $self->log->debug('[수선] 허리');
                    $self->log->debug('[수선] 허벅지');
                    $self->log->debug('[수선] 밑단');
                    $done = 1;
                }
                else {
                    $bottom{waist} = $waist + $stretch;
                    $bottom{thigh} = $WAIST_THIGH_MAP{ $bottom{waist} };
                    $bottom{cuff}  = $WAIST_CUFF_MAP{ $bottom{waist} };
                    $self->log->debug('[수선] 허리');
                    $self->log->debug('[수선] 허벅지');
                    $self->log->debug('[수선] 밑단');
                }
            }
            elsif ( $deviation < 5 ) {
                $bottom{waist} = $topbelly - 7;
                $bottom{thigh} = $WAIST_THIGH_MAP{ $bottom{waist} };
                $bottom{cuff}  = $WAIST_CUFF_MAP{ $bottom{waist} };
                $self->log->debug('[수선] 허리');
                $self->log->debug('[수선] 허벅지');
                $self->log->debug('[수선] 밑단');
                $done = 1;
            }

            $self->log->unsubscribe('message');

            if ($top) {
                $category = $JACKET;
                continue;
            }
        }
        when (/$SKIRT/) {

            $self->log->on(
                message => sub {
                    my ( $log, $level, @lines ) = @_;
                    push @bottom_desc, @lines;
                }
            );

            $bottom{waist}  = $HIP_WAIST_MAP{$hip}  || 0;
            $bottom{length} = $HIP_LENGTH_MAP{$hip} || 0;
            $self->log->debug('[수선] 허리');
            $self->log->debug('[수선] 길이');
            my $distinction = $waist - $bottom{waist};
            $distinction *= -1 if $distinction < 0;
            if ( $distinction > 10 ) {
                $bottom{'치마폭'} = '수선필요';
                $self->log->debug('[수선] 치마폭');
            }

            $self->log->unsubscribe('message');
        }
        when (/$JACKET/) {

            $self->log->on(
                message => sub {
                    my ( $log, $level, @lines ) = @_;
                    push @top_desc, @lines;
                }
            );

            if ( $gender eq 'male' ) {
                unless ($done) {
                    my $temp = $bust - $topbelly;
                    $self->log->debug( sprintf "가슴 - 윗배: %scm", $temp );
                    break if $temp < 0 || $temp > 9;

                    if ( $temp == 0 ) {
                        $top{topbelly} = $bust - 4;
                    }
                    elsif ( $temp == 1 ) {
                        $top{topbelly} = $bust - 3;
                    }
                    elsif ( $temp == 2 ) {
                        $top{topbelly} = $bust - 2;
                    }
                    elsif ( $temp == 3 ) {
                        $top{topbelly} = $bust - 1;
                    }
                    elsif ( $temp == 4 ) {
                        $top{topbelly} = $bust - 4;
                    }
                    elsif ( $temp == 5 ) {
                        $top{topbelly} = $bust - 3;
                    }
                    elsif ( $temp == 6 ) {
                        $top{topbelly} = $bust - 2;
                    }
                    elsif ( $temp == 7 ) {
                        $top{topbelly} = $bust - 1;
                    }
                    elsif ( $temp == 8 ) {
                        $top{topbelly} = $bust - 2;
                    }
                    elsif ( $temp == 9 ) {
                        $top{topbelly} = $bust - 1;
                    }

                    $self->log->debug('[수선] 윗배');
                }

                my $length = $top->length || 0;
                $top{arm} = $LENGTH_ARM_MAP{$length} || 0;
                delete $top{arm} unless $top{arm};
                $self->log->debug('[수선] 팔길이');
            }
            elsif ( $gender eq 'female' ) {
                $top{arm} = $TOPBELLY_ARM_MAP{$topbelly} || 0;
                $self->log->debug('[수선] 팔길이');
            }

            $self->log->unsubscribe('message');
        }
        default {
            $self->log->debug("만족하는 조건이 없습니다: $code");
        }
    }

    return { top => \%top, bottom => \%bottom, messages => { top => [@top_desc], bottom => [@bottom_desc] } };
}

1;

__END__

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
