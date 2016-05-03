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

    my $rs     = $self->rs;
    my $code   = $rs->code;
    my $gender = $rs->gender || '';
    my ( $top, $bottom );

    $code =~ s/^0//;
    my $first = substr $code, 0, 1;
    if ( $first =~ /^(J|P|K)/ ) { # Jacket, Pants, sKirt
        if ( $first eq 'J' ) {
            my $suit = $rs->suit_code_top;
            $top = $rs;
            $bottom = $suit->code_bottom if $suit;
        }
        else {
            my $suit = $rs->suit_code_bottom;
            $top = $suit->code_top if $suit;
            $bottom = $rs;
        }
    }
    else {
        print STDERR "Not supported category: $code\n";
        return {};
    }

    my $topbelly = $top    ? $top->topbelly || 0 : 0;
    my $waist    = $bottom ? $bottom->waist || 0 : 0;
    my $deviation = $topbelly - $waist;
    my $hip       = $bottom ? $bottom->hip || 0 : 0;
    my $thigh     = $bottom ? $bottom->thigh || 0 : 0;
    my $cuff      = $bottom ? $bottom->cuff || 0 : 0;

    my %resize;
    use experimental 'switch';
    given ($first) {
        when (/^P/) {
            break if $gender eq 'female';
            $self->log->debug('남자 > 바지');
            if ( $deviation < 0 ) {
                $self->log->debug('셋트의류가 아님');
            }
            elsif ( $deviation >= 5 && $deviation <= 8 ) {
                $self->log->debug('윗배 - 허리: 5cm ~ 8cm');
                $self->log->debug('허리치수에 따라 허벅지입력');
                $self->log->debug('허리치수에 따라 밑통입력');
                $self->log->debug('완료');
                $resize{thigh} = $WAIST_THIGH_MAP{$waist};
                $resize{cuff}  = $WAIST_CUFF_MAP{$waist};
            }
            elsif ( $deviation > 8 ) {
                $self->log->debug('윗배 - 허리 > 8cm');
                if ( $opts->{avail_stretch_waist} ) {
                    $self->log->debug('허리늘임 가능');
                    $self->log->debug('허리 = 윗배 - 9');
                    $self->log->debug('허리치수에 따라 허벅지입력');
                    $self->log->debug('허리치수에 따라 밑통입력');
                    $self->log->debug('완료');
                    $resize{waist} = $topbelly - 9;
                    $resize{thigh} = $WAIST_THIGH_MAP{ $resize{$waist} };
                    $resize{cuff}  = $WAIST_CUFF_MAP{ $resize{$waist} };
                }
                else {
                    if ( $opts->{tuck1} ) {
                        $self->log->debug('1턱일 경우');
                        ## 윗배 - 허리 = 9 가능?
                        ## 윗배 - 허리 = 9 어려움?
                    }
                    elsif ( $opts->{tuck2} ) {
                        $self->log->debug('2턱일 경우');
                        # 1턱 품: 4cm 늘어남?
                        # 2턱 품: 8cm 늘어남?
                        # 윗배 - 허리 = 9cm 안됨?
                    }
                    else {
                        $self->log->debug('노턱이거나 늘일 수 없을때');
                    }
                }
            }
            elsif ( $deviation < 5 ) {
                $self->log->debug('허리 = 윗배 - 7');
                $self->log->debug('허리치수에 따라 허벅지입력');
                $self->log->debug('허리치수에 따라 밑통입력');
                $self->log->debug('완료');
                $resize{waist} = $topbelly - 7;
                $resize{thigh} = $WAIST_THIGH_MAP{ $resize{$waist} };
                $resize{cuff}  = $WAIST_CUFF_MAP{ $resize{$waist} };
            }
        }
        when (/^J/) {
            if ( $gender eq 'male' ) {
                $self->log->debug('남자 > 자켓');
                if ( $topbelly - $waist < 9 ) {
                    $self->log->debug('윗배 - 허리 < 9cm');
                    $self->log->debug('총장에 따라 팔길이 입력');
                    $self->log->debug('완료');
                    # 총장에 따른 팔길이가 없음
                }
                elsif ( $topbelly - $waist > 10 ) {
                    $self->log->debug('윗배 - 허리 > 10cm');
                }
            }
            elsif ( $gender eq 'female' ) {
                $self->log->debug('여자 > 자켓');
            }
        }
        when (/^K/) {
            my $length = $rs->length || 0;
            $self->log->debug('여자 > 치마');
            $self->log->debug('엉덩이 둘레에 따라 허리입력');
            $self->log->debug('엉덩이 둘레에 따라 기장입력');
            $self->log->debug('완료');
            $resize{waist}  = $HIP_WAIST_MAP{$hip};
            $resize{length} = $HIP_LENGTH_MAP{$hip};
        }
        default {
            $self->log->debug("만족하는 조건이 없습니다: $code");
        }
    }

    return {%resize};
}

1;

__END__

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
