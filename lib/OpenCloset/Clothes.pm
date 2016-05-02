package OpenCloset::Clothes;

=encoding utf8

=head1 NAME

OpenCloset::Clothes - clothes funtions and so..

=head1 SYNOPSIS

    my $clothes = OpenCloset::Clothes->new(clothes => $clothes);
    my hashref  = $clothes->suggest_repair_size;

=cut

use Moo;

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
    108 => 84,
    110 => 76,
    112 => 76,
    114 => 78,
    116 => 78,
    118 => 80,
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
);

has clothes => ( is => 'ro', required => 1 );
has rs => ( is => 'ro', default => sub { shift->clothes } );

=head1 METHODS

=head2 suggest_repair_size

    my $hashref = $clothes->suggest_repair_size;
    # {
    #   bust  => 95
    #   waist => 78,
    # }

=cut

sub suggest_repair_size {
    my ( $self, $opts ) = @_;

    my $rs   = $self->rs;
    my $code = $rs->code;
    my ( $top, $bottom );

    $code =~ s/^0//;
    my $first = substr $code, 0, 1;
    if ( $first =~ /^(J|P|K)/ ) {    # Jacket, Pants, sKirt
        if ( $first eq 'J' ) {
            my $suit = $rs->suit_code_top;
            $top    = $rs;
            $bottom = $suit->code_bottom;
        }
        else {
            my $suit = $rs->suit_code_bottom;
            $top    = $suit->code_top;
            $bottom = $rs;
        }
    }
    else {
        print STDERR "Not supported category: $code\n";
        return {};
    }

    use experimental 'switch';
    given ($first) {
        when (/^P/) {
            my $topbelly = $top ? $top->topbelly : 0;
            my $waist = $bottom->waist || 0;
            my %resize;
            my ( $thigh, $cuff );
            my $deviation = $topbelly - $waist;
            if ( $deviation >= 5 && $deviation <= 8 ) {
                $resize{thigh} = $WAIST_THIGH_MAP{$waist};
                $resize{cuff}  = $WAIST_CUFF_MAP{$waist};
            }
            elsif ( $deviation > 8 ) {
                if ( $opts->{avail_stretch_waist} ) {
                    $resize{waist} = $topbelly - 9;
                    $resize{thigh} = $WAIST_THIGH_MAP{ $resize{$waist} };
                    $resize{cuff}  = $WAIST_CUFF_MAP{ $resize{$waist} };
                }
                else {
                    if ( $opts->{tuck1} ) {
                    }
                    elsif ( $opts->{tuck2} ) {
                    }
                }
            }
        }
        when (/^J/) { }
        when (/^K/) { }
        default {
        }
    }
}

1;

__END__

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 열린옷장

=cut
