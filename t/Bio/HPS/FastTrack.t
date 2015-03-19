#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack');
}

ok ( my $hps_fast_track =  Bio::HPS::FastTrack->new( study => '2465', database => 'bacteria' ), 'Creating HPS::FastTrack object' );
is ( $hps_fast_track->study(), '2465', 'Study id comparison');
is ( $hps_fast_track->database(), 'bacteria', 'Database name comparison');
is_deeply ( $hps_fast_track->analysis(), ['all'], 'Analysis types comparison');
isa_ok ( $hps_fast_track->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::ConfigHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_mapping =  Bio::HPS::FastTrack->new( study => '5462', database => 'bacteria', analysis => ['mapping'] ), 'Creating bacteria mapping HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_mapping->study(), '5462', 'Study id comparison bacteria mapping');
is ( $hps_fast_track_bacteria_mapping->database(), 'bacteria', 'Database name comparison bacteria mapping');
is_deeply ( $hps_fast_track_bacteria_mapping->analysis(), ['mapping'], 'Analysis types comparison bacteria mapping');
isa_ok ( $hps_fast_track_bacteria_mapping->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::MappingHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_assembly_annotation =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', analysis => ['assembly','annotation'] ), 'Creating bacteria assembly and annotation HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_assembly_annotation->study(), '4562', 'Study id comparison assembly and annotation');
is ( $hps_fast_track_bacteria_assembly_annotation->database(), 'bacteria', 'Database name comparison assembly and annotation');
is_deeply ( $hps_fast_track_bacteria_assembly_annotation->analysis(), ['assembly','annotation'], 'Analysis types comparison assembly and annotation');
isa_ok ( $hps_fast_track_bacteria_assembly_annotation->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::AssemblyAndAnnotationHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_snp_calling =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', analysis => ['snp-calling'] ), 'Creating bacteria snp-calling HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_snp_calling->study(), '4562', 'Study id comparison snp-calling');
is ( $hps_fast_track_bacteria_snp_calling->database(), 'bacteria', 'Database name comparison snp-calling');
is_deeply ( $hps_fast_track_bacteria_snp_calling->analysis(), ['snp-calling'], 'Analysis types comparison snp-calling');
isa_ok ( $hps_fast_track_bacteria_snp_calling->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::SNPCallingHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_rna_seq =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', analysis => ['rna-seq'] ), 'Creating bacteria rna-seq HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_rna_seq->study(), '4562', 'Study id comparison rna-seq');
is ( $hps_fast_track_bacteria_rna_seq->database(), 'bacteria', 'Database name comparison rna-seq');
is_deeply ( $hps_fast_track_bacteria_rna_seq->analysis(), ['rna-seq'], 'Analysis types comparison rna-seq');
isa_ok ( $hps_fast_track_bacteria_rna_seq->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::RNASeqHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_pan_genome =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', analysis => ['pan-genome'] ), 'Creating bacteria pan-genome HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_pan_genome->study(), '4562', 'Study id comparison pan-genome');
is ( $hps_fast_track_bacteria_pan_genome->database(), 'bacteria', 'Database name comparison pan-genome');
is_deeply ( $hps_fast_track_bacteria_pan_genome->analysis(), ['pan-genome'], 'Analysis types comparison pan-genome');
isa_ok ( $hps_fast_track_bacteria_pan_genome->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::PanGenomeHandler', 'Config module hook' );

ok ( my $hps_fast_track_bacteria_tradis =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', analysis => ['tradis'] ), 'Creating bacteria tradis HPS::FastTrack object' );
is ( $hps_fast_track_bacteria_tradis->study(), '4562', 'Study id comparison tradis');
is ( $hps_fast_track_bacteria_tradis->database(), 'bacteria', 'Database name comparison tradis');
is_deeply ( $hps_fast_track_bacteria_tradis->analysis(), ['tradis'], 'Analysis types comparison tradis');
isa_ok ( $hps_fast_track_bacteria_tradis->analysis_config_handler(), 'Bio::HPS::FastTrack::Config::TradisHandler', 'Config module hook' );



done_testing();
