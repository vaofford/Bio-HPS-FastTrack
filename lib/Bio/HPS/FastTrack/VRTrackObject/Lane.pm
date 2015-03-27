package Bio::HPS::FastTrack::VRTrackObject::Lane;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_lane = Bio::HPS::FastTrack::VRTrackObject::Lane->new(lane_name => $name, sample_id => $sample_id, processed => $processed_flag});

=cut

use Moose;
use Bio::HPS::FastTrack::Types::FastTrackTypes;
extends('Bio::HPS::FastTrack::VRTrackObject::VRTrack');

has 'lane_name'      => ( is => 'rw', isa => 'Str', required => 1 );
has 'vrlane' => ( is => 'rw', isa => 'VRTrack::Lane', lazy => 1, builder => '_build_vrtrack_lane' );
has 'sample_id'      => ( is => 'rw', isa => 'Str', required => 1 );
has 'processed'      => ( is => 'rw', isa => 'Int', required => 1 );
has 'study_name'     => ( is => 'rw', isa => 'Str', required => 1 );
has 'storage_path'   => ( is => 'rw', isa => 'LaneStoragePath', required => 1 );
has 'pipeline_stage' => ( is => 'rw', isa => 'Str', lazy => 1, default => 'no flag' );

sub _build_vrtrack_lane {

  my ($self) = @_;

  my $vrlane = VRTrack::Lane->new_by_name($self->vrtrack, '11250_1#27');
  return $vrlane;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
