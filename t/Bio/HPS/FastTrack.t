#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
  use Test::Most;
  use Test::Exception;
  use_ok('Bio::HPS::FastTrack');
}

# ok ( my $hps_fast_track =  Bio::HPS::FastTrack->new( study => '2465', database => 'bacteria' ), 'Creating HPS::FastTrack object' );
# is ( $hps_fast_track->study(), '2465', 'Study id comparison');
# is ( $hps_fast_track->database(), 'bacteria', 'Database name comparison');
# is_deeply ( $hps_fast_track->pipeline(), [], 'Pipeline types comparison');
# isa_ok ( $hps_fast_track->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::PipelineRun' );
ok ( my $hps_fast_track_non_existant_database = Bio::HPS::FastTrack->new( study => '2027', database => 'clown_database' ), 'Creating HPS::FastTrack object' );
throws_ok { $hps_fast_track_non_existant_database->run() } qr/Error: Could not connect to database/ , 'Non existent database exception thrown' ;

ok ( my $hps_fast_track_bacteria_mapping =  Bio::HPS::FastTrack->new( study => '2027', database => 'pathogen_prok_track_test', pipeline => ['mapping'] ), 'Creating bacteria mapping HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_mapping->study(), '2027', 'Study id comparison bacteria mapping');
is ( $hps_fast_track_bacteria_mapping->database(), 'pathogen_prok_track_test', 'Database name comparison bacteria mapping');
is_deeply ( $hps_fast_track_bacteria_mapping->pipeline(), ['mapping'], 'Pipeline types comparison bacteria mapping');
isa_ok ( $hps_fast_track_bacteria_mapping->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Mapping' );

throws_ok { $hps_fast_track_bacteria_mapping->run() } qr/sysopen: No such file or directory at/ , 'Non existent config root exception thrown' ;
#is ( $hps_fast_track_bacteria_mapping->pipeline_runners()->[0]->config_data()->config_root(), '/nfs/pathnfs05/conf', 'The default conf path' );
#is ( $hps_fast_track_bacteria_mapping->pipeline_runners()->[0]->config_data()->path_to_high_level_config(), '/nfs/pathnfs05/conf/pathogen_prok_track_test/pathogen_prok_track_test_mapping_pipeline.conf', 'High level config' );
#throws_ok { $hps_fast_track_bacteria_mapping->pipeline_runners()->[0]->config_data()->path_to_low_level_config() } qr/sysopen: No such file or directory at/ , 'Non existent config root exception thrown' ;


ok ( my $hps_fast_track_bacteria_mapping2 =  Bio::HPS::FastTrack->new( study => '2027', database => 'pathogen_prok_track_test', pipeline => ['mapping'] ), 'Creating bacteria mapping HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_mapping2->study(), '2027', 'Study id comparison bacteria mapping');
is ( $hps_fast_track_bacteria_mapping2->database(), 'pathogen_prok_track_test', 'Database name comparison bacteria mapping');
is_deeply ( $hps_fast_track_bacteria_mapping2->pipeline(), ['mapping'], 'Pipeline types comparison bacteria mapping');
isa_ok ( $hps_fast_track_bacteria_mapping2->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Mapping' );
ok ( $hps_fast_track_bacteria_mapping2->pipeline_runners()->[0]->config_data()->config_root('t/data/conf'), 'Setting the test conf root path' );
is ( $hps_fast_track_bacteria_mapping2->pipeline_runners()->[0]->config_data()->config_root(), 't/data/conf', 'Proper path now' );
$hps_fast_track_bacteria_mapping2->run();
is ( $hps_fast_track_bacteria_mapping2->pipeline_runners()->[0]->config_data()->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_mapping_pipeline.conf', 'High level config' );
is ( $hps_fast_track_bacteria_mapping2->pipeline_runners()->[0]->config_data()->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/mapping/mapping_Comparative_RNA_seq_analysis_of_three_bacterial_species_Streptococcus_pyogenes_Streptococcus_pyogenes_BC2_HKU16_v0.1_bwa.conf', 'Low level config' );

   
ok ( my $hps_fast_track_bacteria_assembly_annotation =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['assembly','annotation'] ), 'Creating bacteria assembly and annotation HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_assembly_annotation->study(), '4562', 'Study id comparison assembly and annotation');
is ( $hps_fast_track_bacteria_assembly_annotation->database(), 'bacteria', 'Database name comparison assembly and annotation');
is_deeply ( $hps_fast_track_bacteria_assembly_annotation->pipeline(), ['assembly','annotation'], 'Pipeline types comparison assembly and annotation');
isa_ok ( $hps_fast_track_bacteria_assembly_annotation->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Assembly' );
isa_ok ( $hps_fast_track_bacteria_assembly_annotation->pipeline_runners()->[1], 'Bio::HPS::FastTrack::PipelineRun::Annotation' );

ok ( my $hps_fast_track_bacteria_snp_calling =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['snp-calling'] ), 'Creating bacteria snp-calling HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_snp_calling->study(), '4562', 'Study id comparison snp-calling');
is ( $hps_fast_track_bacteria_snp_calling->database(), 'bacteria', 'Database name comparison snp-calling');
is_deeply ( $hps_fast_track_bacteria_snp_calling->pipeline(), ['snp-calling'], 'Pipeline types comparison snp-calling');
isa_ok ( $hps_fast_track_bacteria_snp_calling->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::SNPCalling' );

ok ( my $hps_fast_track_bacteria_rna_seq =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['rna-seq'] ), 'Creating bacteria rna-seq HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_rna_seq->study(), '4562', 'Study id comparison rna-seq');
is ( $hps_fast_track_bacteria_rna_seq->database(), 'bacteria', 'Database name comparison rna-seq');
is_deeply ( $hps_fast_track_bacteria_rna_seq->pipeline(), ['rna-seq'], 'Pipeline types comparison rna-seq');
isa_ok ( $hps_fast_track_bacteria_rna_seq->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis' );

ok ( my $hps_fast_track_bacteria_pan_genome =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['pan-genome'] ), 'Creating bacteria pan-genome HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_pan_genome->study(), '4562', 'Study id comparison pan-genome');
is ( $hps_fast_track_bacteria_pan_genome->database(), 'bacteria', 'Database name comparison pan-genome');
is_deeply ( $hps_fast_track_bacteria_pan_genome->pipeline(), ['pan-genome'], 'Pipeline types comparison pan-genome');
isa_ok ( $hps_fast_track_bacteria_pan_genome->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis' );

ok ( my $hps_fast_track_bacteria_tradis =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['tradis'] ), 'Creating bacteria tradis HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_tradis->study(), '4562', 'Study id comparison tradis');
is ( $hps_fast_track_bacteria_tradis->database(), 'bacteria', 'Database name comparison tradis');
is_deeply ( $hps_fast_track_bacteria_tradis->pipeline(), ['tradis'], 'Pipeline types comparison tradis');
isa_ok ( $hps_fast_track_bacteria_tradis->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::TradisAnalysis' );

ok ( my $hps_fast_track_bacteria_mapping_assembly_annotation =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['mapping','assembly','annotation'] ), 'Creating bacteria mapping, assembly and annotation HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_mapping_assembly_annotation->study(), '4562', 'Study id comparison mapping, assembly and annotation');
is ( $hps_fast_track_bacteria_mapping_assembly_annotation->database(), 'bacteria', 'Database name comparison mapping, assembly and annotation');
is_deeply ( $hps_fast_track_bacteria_mapping_assembly_annotation->pipeline(), ['mapping','assembly','annotation'], 'Pipeline types comparison mapping, assembly and annotation');
isa_ok ( $hps_fast_track_bacteria_mapping_assembly_annotation->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Mapping' );
isa_ok ( $hps_fast_track_bacteria_mapping_assembly_annotation->pipeline_runners()->[1], 'Bio::HPS::FastTrack::PipelineRun::Assembly' );
isa_ok ( $hps_fast_track_bacteria_mapping_assembly_annotation->pipeline_runners()->[2], 'Bio::HPS::FastTrack::PipelineRun::Annotation' );

ok ( my $hps_fast_track_bacteria_all =  Bio::HPS::FastTrack->new( study => '5462', database => 'bacteria', pipeline => ['all'] ), 'Creating bacteria all pipelines HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_all->study(), '5462', 'Study id comparison bacteria all');
is ( $hps_fast_track_bacteria_all->database(), 'bacteria', 'Database name comparison bacteria all');
is_deeply ( $hps_fast_track_bacteria_all->pipeline(), ['all'], 'Pipeline types comparison bacteria all');
is (scalar @{$hps_fast_track_bacteria_all->pipeline_runners()}, 7, 'All pipelines will be run bacteria all');
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Mapping' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[1], 'Bio::HPS::FastTrack::PipelineRun::Assembly' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[2], 'Bio::HPS::FastTrack::PipelineRun::Annotation' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[3], 'Bio::HPS::FastTrack::PipelineRun::SNPCalling' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[4], 'Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[5], 'Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis' );
isa_ok ( $hps_fast_track_bacteria_all->pipeline_runners()->[6], 'Bio::HPS::FastTrack::PipelineRun::TradisAnalysis' );

done_testing();
