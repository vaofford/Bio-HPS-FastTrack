#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Mapping');
  }

ok( my $mapping_runner = Bio::HPS::FastTrack::PipelineRun::Mapping->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a Mapping runner object');
isa_ok ( $mapping_runner, 'Bio::HPS::FastTrack::PipelineRun::Mapping' );
ok ( $mapping_runner->study_metadata(), 'Creating study object');
isa_ok ( $mapping_runner->study_metadata(), 'Bio::HPS::FastTrack::VRTrackWrapper::Study');
ok ( $mapping_runner->study_metadata()->lanes(), 'Collecting lanes');

$mapping_runner->run();
isa_ok ($mapping_runner->study_metadata()->lanes()->{'7138_6#17'}, 'VRTrack::Lane');
is( $mapping_runner->study_metadata->vrtrack_study->hierarchy_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name mapped');
is( $mapping_runner->study_metadata()->lanes()->{'7138_6#17'}->processed(), 15, 'Processed flag mapped');
is( $mapping_runner->study_metadata()->lanes()->{'7138_6#17'}->hierarchy_name(), '7138_6#17', 'Lane name mapped');

is( $mapping_runner->study_metadata()->lanes()->{'7153_1#20'}->processed(), 1035, 'Processed flag not mapped');
is( $mapping_runner->study_metadata()->lanes()->{'7153_1#20'}->hierarchy_name(), '7153_1#20', 'Lane name not mapped');

ok ( $mapping_runner->config_data(), 'Creating config object');
ok ( $mapping_runner->config_data->config_root('t/data/conf'), 'Set new root path' );
is ( $mapping_runner->config_data->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_mapping_pipeline.conf', 'High level config' );
is ( $mapping_runner->config_data->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/mapping/mapping_Comparative_RNA_seq_analysis_of_three_bacterial_species_Streptococcus_pyogenes_Streptococcus_pyogenes_BC2_HKU16_v0.1_bwa.conf',
     'Low level config'
   );

#print Dumper($mapping_runner);

ok( my $mapping_runner3 = Bio::HPS::FastTrack::PipelineRun::Mapping->new( lane => '7153_1#20' , database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a Mapping runner object');
isa_ok ( $mapping_runner3, 'Bio::HPS::FastTrack::PipelineRun::Mapping' );
ok ( $mapping_runner3->lane_metadata(), 'Collecting lane metadata' );
$mapping_runner3->run();
print Dumper($mapping_runner3);

done_testing();
