#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
  use Test::Most;
  use_ok('Bio::HPS::FastTrack::VRTrackObject::Study');
  }

#my %test_database_lookup = ( 'pathogen_prok_track_external' => 't/data/database/test.db' );

ok( my $study = Bio::HPS::FastTrack::VRTrackObject::Study->new(study => 2027, database => 'pathogen_prok_track_test', mode => 'prod'), 'Study object creation' );
isa_ok( $study, 'Bio::HPS::FastTrack::VRTrackObject::Study', 'Study object');
isa_ok ( $study->vrtrack(), 'VRTrack::VRTrack' );
isa_ok( $study->vrtrack_study(), 'VRTrack::Project');
#$study->vrtrack_study();
#print Dumper($study);
#

=head

ok( my $study = Bio::HPS::FastTrack::VRTrackObject::Study->new(study => 2027, database => 't/data/database/test.db' , mode => 'test'), 'Study object creation' );
isa_ok( $study, 'Bio::HPS::FastTrack::VRTrackObject::Study', 'Study object');
isa_ok( $study->vrtrack_study, 'VRTrack::Study', 'VR study object');
isa_ok($study->lanes()->[0], 'Bio::HPS::FastTrack::VRTrackObject::Lane', 'Lane object');

for my $l(@{$study->lanes()}) {
  $l->pipeline_stage();
}

is($study->study_name, 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');

my $lane = $study->lanes()->[0];
is($lane->study_name, 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Lane study name');
is($lane->sample_id, 79, 'Sample ID');
is($lane->processed, 15, 'Processed flag');
is($lane->lane_name, '7138_6#17', 'Lane name');
is($lane->storage_path, 'no storage path retrieved', 'Storage path');
is($lane->pipeline_stage, 'no flag', 'Pipeline Stage');

#print Dumper($study);

=cut

done_testing();

