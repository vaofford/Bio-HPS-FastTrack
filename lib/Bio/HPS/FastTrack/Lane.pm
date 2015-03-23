package Bio::HPS::FastTrack::Lane;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_lane = Bio::HPS::FastTrack::Lane->new(lane_name => $name, sample_id => $sample_id, processed => $processed_flag});

=cut

use Moose;

has 'lane_name'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'sample_id'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'processed'   => ( is => 'rw', isa => 'Int', required => 1 );
has 'study_name'   => ( is => 'rw', isa => 'Str', required => 1 );



no Moose;
__PACKAGE__->meta->make_immutable;
1;
