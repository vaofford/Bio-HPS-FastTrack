#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::SNPCalling');
  }

ok( my $snp_calling_runner = Bio::HPS::FastTrack::PipelineRun::SNPCalling->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a SNPCalling runner object');
isa_ok ( $snp_calling_runner, 'Bio::HPS::FastTrack::PipelineRun::SNPCalling' );
ok ( my $study = $snp_calling_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::VRTrackWrapper::Study');
ok ( $study->lanes(), 'Collecting lanes');

$snp_calling_runner->run();
isa_ok ($study->lanes()->{'7138_6#17'}, 'VRTrack::Lane');
is( $snp_calling_runner->study_metadata->vrtrack_study->hierarchy_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is( $study->lanes()->{'7138_6#17'}->processed(), 15, 'Processed flag');
is( $study->lanes()->{'7138_6#17'}->hierarchy_name(), '7138_6#17', 'Lane name');

is( $study->lanes()->{'7153_1#20'}->processed(), 1035, 'Processed flag snp-called2');
is( $study->lanes()->{'7153_1#20'}->hierarchy_name(), '7153_1#20', 'Lane name snp-called2');


ok ( my $config = $snp_calling_runner->config_data(), 'Creating config object');
is ( $config->config_root(), '/nfs/pathnfs05/conf', 'Root path of config files');
ok ( $config->config_root('t/data/conf'), 'Creating config object');
is ( $config->config_root(), 't/data/conf', 'Root path of config files');
is ( $config->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_snps_pipeline.conf', 'Annotation test configuration directory');
is ( $config->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/snps/snps_Comparative_RNA_seq_analysis_of_three_bacterial_species_Streptococcus_pyogenes_Streptococcus_pyogenes_BC2_HKU16_v0.1_bwa.conf',
     'Low level config'
   );

done_testing();
