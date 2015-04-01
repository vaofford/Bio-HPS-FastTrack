#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis');
  }

ok( my $rna_seq_analysis_runner = Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a RNASeqAnalysis runner object');
isa_ok ( $rna_seq_analysis_runner, 'Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis' );
ok ( my $study = $rna_seq_analysis_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::VRTrackWrapper::Study');
ok ( $study->lanes(), 'Collecting lanes');

$rna_seq_analysis_runner->run();

isa_ok ($study->lanes()->{'7138_6#17'}, 'VRTrack::Lane');
is( $rna_seq_analysis_runner->study_metadata->vrtrack_study->hierarchy_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name rna-seq');
is( $study->lanes()->{'7138_6#17'}->processed(), 15, 'Processed flag rna-seq');
is( $study->lanes()->{'7138_6#17'}->hierarchy_name(), '7138_6#17', 'Lane name rna-seq');

is( $study->lanes()->{'7229_2#35'}->processed(), 517, 'Processed flag rna-seq2');
is( $study->lanes()->{'7229_2#35'}->hierarchy_name(), '7229_2#35', 'Lane name rna-seq2');


ok ( my $config = $rna_seq_analysis_runner->config_data(), 'Creating config object');
is ( $config->config_root(), '/nfs/pathnfs05/conf', 'Root path of config files');
ok ( $config->config_root('t/data/conf'), 'Creating config object');
is ( $config->config_root(), 't/data/conf', 'Root path of config files');
is ( $config->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_rna_seq_pipeline.conf', 'RNASeq test configuration directory');
is ( $config->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/rna_seq/rna_seq_Comparative_RNA_seq_analysis_of_three_bacterial_species_Streptococcus_pyogenes_Streptococcus_pyogenes_BC2_HKU16_v0.1_bwa.conf',
     'Low level config'
     );


done_testing();
