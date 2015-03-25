#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::Config');
  }

ok( my $config = Bio::HPS::FastTrack::Config->new(
						 study_name => 'Comparative_RNA_seq_analysis_of_three_bacterial_species',
						 database => 'pathogen_prok_track_test',
						 add_to_config_path => 'mapping',
						 db_alias => 'no alias',
						), 'Config object creation' );


ok ( $config->config_root('t/data/conf'), 'Set new root path' );
is ( $config->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_mapping_pipeline.conf', 'High level config' );
is ( $config->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/mapping/mapping_Comparative_RNA_seq_analysis_of_three_bacterial_species_Streptococcus_pyogenes_Streptococcus_pyogenes_BC2_HKU16_v0.1_bwa.conf',
     'Low level config'
   );

ok( $config = Bio::HPS::FastTrack::Config->new(
						 study_name => 'Comparative_RNA_seq_analysis_of_three_bacterial_species',
						 database => 'pathogen_prok_track_test',
						 add_to_config_path => 'assembly',
						 db_alias => 'no alias',
						), 'Config object creation' );


ok ( $config->config_root('t/data/conf'), 'Set new root path' );
is ( $config->path_to_high_level_config(), 't/data/conf/pathogen_prok_track_test/pathogen_prok_track_test_assembly_pipeline.conf', 'High level config' );
is ( $config->path_to_low_level_config(),
     't/data/conf/pathogen_prok_track_test/assembly/assembly_Comparative_RNA_seq_analysis_of_three_bacterial_species_velvet.conf',
     'Low level config'
   );


done_testing();
