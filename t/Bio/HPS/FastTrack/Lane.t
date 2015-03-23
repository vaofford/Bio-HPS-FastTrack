#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::Lane');
  }

ok( my $hps_lane = Bio::HPS::FastTrack::Lane->new( study_name => 'Comparative_RNA_seq_analysis_of_three_bacterial_species', sample_id => '19', processed => '1', lane_name => '8405_4#6' ), 'Lane object creation' );
isa_ok($hps_lane, 'Bio::HPS::FastTrack::Lane', 'Lane object');
is( $hps_lane->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is( $hps_lane->sample_id(), 19, 'Sample ID');
is( $hps_lane->processed(), 1, 'Processed flag');
is( $hps_lane->lane_name(), '8405_4#6', 'Lane name');
is( $hps_lane->pipeline_stage(), 'qc', 'Pipeline stage');
done_testing();
