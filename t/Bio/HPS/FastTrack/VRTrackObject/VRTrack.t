#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
  use Test::Most;
  use Test::Exception;
  use_ok('Bio::HPS::FastTrack::VRTrackObject::VRTrack');
}

isa_ok ( my $hps_vrtrack = Bio::HPS::FastTrack::VRTrackObject::VRTrack->new( database => 'pathogen_prok_track_test', mode => 'prod'), 'Bio::HPS::FastTrack::VRTrackObject::VRTrack' );
isa_ok ( my $vrtrack_obj = $hps_vrtrack->vrtrack(), 'VRTrack::VRTrack' );


#print Dumper($project);

done_testing();
