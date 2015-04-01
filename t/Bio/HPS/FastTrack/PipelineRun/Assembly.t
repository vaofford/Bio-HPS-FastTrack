#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Assembly');
  }

ok( my $assembly_runner = Bio::HPS::FastTrack::PipelineRun::Assembly->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a Assembly runner object');
isa_ok ( $assembly_runner, 'Bio::HPS::FastTrack::PipelineRun::Assembly' );
ok ( my $study = $assembly_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::VRTrackWrapper::Study');
ok ( $study->lanes(), 'Collecting lanes');

$assembly_runner->run();

isa_ok ($study->lanes()->{'7138_6#17'}, 'VRTrack::Lane');
is( $assembly_runner->study_metadata->vrtrack_study->hierarchy_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name not assembled');
is( $study->lanes()->{'7138_6#17'}->processed(), 15, 'Processed flag not assembled');
is( $study->lanes()->{'7138_6#17'}->hierarchy_name(), '7138_6#17', 'Lane name not assembled');

is( $study->lanes()->{'7153_1#20'}->processed(), 1035, 'Processed flag assembled');
is( $study->lanes()->{'7153_1#20'}->hierarchy_name(), '7153_1#20', 'Lane name assembled');


ok ( my $config = $assembly_runner->config_data(), 'Creating config object');
is ( $config->config_root(), '/nfs/pathnfs05/conf', 'Root path of config files');
ok ( $config->config_root('t/data/conf'), 'Creating config object');
is ( $config->config_root(), 't/data/conf', 'Root path of config files');
is ( $config->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_assembly_pipeline.conf', 'Assembly high level config file');
is ( $config->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/assembly/assembly_Comparative_RNA_seq_analysis_of_three_bacterial_species_velvet.conf',
     'Low level config'
   );
done_testing();
