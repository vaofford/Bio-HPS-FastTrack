package Bio::HPS::FastTrack::VRTrackWrapper::Lane;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_lane = Bio::HPS::FastTrack::VRTrackObject::Lane->new(
							     database => 'pathogen_prok_track_test',
							     mode => 'prod',
							     lane_name => '7229_2#35',
							    )->vrlane;


=cut

use Moose;
use Bio::HPS::FastTrack::Types::FastTrackTypes;
extends('Bio::HPS::FastTrack::VRTrackWrapper::VRTrack');

has 'lane_name'      => ( is => 'rw', isa => 'Str', required => 1 );
has 'vrlane' => ( is => 'rw', isa => 'VRLane', lazy => 1, builder => '_build_vrtrack_lane' );

sub _build_vrtrack_lane {

  my ($self) = @_;
  my $vrlane = VRTrack::Lane->new_by_name($self->vrtrack, $self->lane_name);
  if (defined $vrlane && $vrlane ne qq()) {
    return $vrlane;
  }
  else {
    return _lane_not_found($self->lane_name);
  }
}

sub _lane_not_found {
  my ($lane_name) = @_;
  my %lane_not_found = (
			lane_name => $lane_name,
			status => 'lane not found in tracking database' );
  bless(\%lane_not_found, "VRLane");
  return \%lane_not_found;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
