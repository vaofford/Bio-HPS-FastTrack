#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::PipelineRun');
  }

ok( my $pipeline_runner = Bio::HPS::FastTrack::PipelineRun::PipelineRun->new( study =>  2027, database => 'pathogen_prok_track_test' ), 'Creating a Pipeline runner object');
isa_ok ( $pipeline_runner, 'Bio::HPS::FastTrack::PipelineRun::PipelineRun' );
is( $pipeline_runner->db_alias, 'no alias', 'Standard database' );
is ( $pipeline_runner->allowed_processed_flags()->{'import'}, 1, 'Import flag');
is ( $pipeline_runner->allowed_processed_flags()->{'qc'}, 2, 'QC flag');
ok ( my $study = $pipeline_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::Study');
ok ( $study->lanes(), 'Collecting lanes');

isa_ok ($study->lanes()->[0], 'Bio::HPS::FastTrack::Lane');
is( $study->lanes()->[0]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is( $study->lanes()->[0]->sample_id(), 79, 'Sample ID');
is( $study->lanes()->[0]->processed(), 15, 'Processed flag');
is( $study->lanes()->[0]->lane_name(), '7138_6#17', 'Lane name');

ok ( my $config = $pipeline_runner->config_data(), 'Creating config object');
is ( $config->config_root(), '/nfs/pathnfs05/conf', 'Root path of config files');
#print Dumper($pipeline_runner);

ok( my $pipeline_runner2 = Bio::HPS::FastTrack::PipelineRun::PipelineRun->new( study =>  2027, database => 'pathogen_prok_track' ), 'Creating a Pipeline runner object');
is( $pipeline_runner2->db_alias, 'prokaryotes', 'Non standard database' );
done_testing();
