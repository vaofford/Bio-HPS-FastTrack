#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::Config');
  }

ok( my $study = Bio::HPS::FastTrack::Config->new(study_name => 'Comparative_RNA_seq_analysis_of_three_bacterial_species', database => 'pathogen_prok_track_test'), 'Config object creation' );


done_testing();
