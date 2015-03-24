#!/usr/bin/env perl
use Moose;
use Data::Dumper;
BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Assembly');
  }

ok( my $assembly_runner = Bio::HPS::FastTrack::PipelineRun::Assembly->new( study =>  2027, database => 'pathogen_prok_track_test' ), 'Creating a Assembly runner object');
isa_ok ( $assembly_runner, 'Bio::HPS::FastTrack::PipelineRun::Assembly', 'PipelineRun module hook' );
ok ( my $study = $assembly_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::Study');
ok ( $study->lanes(), 'Collecting lanes');

$assembly_runner->run();

isa_ok ($study->lanes()->[0], 'Bio::HPS::FastTrack::Lane');
is( $study->lanes()->[0]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name not assembled');
is( $study->lanes()->[0]->sample_id(), 79, 'Sample ID not assembled');
is( $study->lanes()->[0]->processed(), 15, 'Processed flag not assembled');
is( $study->lanes()->[0]->lane_name(), '7138_6#17', 'Lane name not assembled');
is( $study->lanes()->[0]->pipeline_stage(), 'not assembled', 'Pipeline stage not assembled');

is( $study->lanes()->[1]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name assembled');
is( $study->lanes()->[1]->sample_id(), 76, 'Sample ID assembled');
is( $study->lanes()->[1]->processed(), 1035, 'Processed flag assembled');
is( $study->lanes()->[1]->lane_name(), '7153_1#20', 'Lane name assembled');
is( $study->lanes()->[1]->pipeline_stage(), 'assembled', 'Pipeline stage assembled');

ok ( my $config = $assembly_runner->config_data(), 'Creating config object');
is ( $config->config_root(), '/nfs/pathnfs05/conf', 'Root path of config files');
ok ( $config->config_root('t/data/conf'), 'Creating config object');
is ( $config->config_root(), 't/data/conf', 'Root path of config files');
is ( $config->path_to_high_level_config(), '/Users/js21/work/Bio-HPS-FastTrack/t/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_assembly_pipeline.conf', 'Assembly test configuration directory');

done_testing();
