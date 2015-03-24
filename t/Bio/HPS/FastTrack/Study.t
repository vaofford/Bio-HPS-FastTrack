#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::Study');
  }

ok( my $study = Bio::HPS::FastTrack::Study->new(study => 2027, database => 'pathogen_prok_track_test'), 'Study object creation' );
isa_ok( $study, 'Bio::HPS::FastTrack::Study', 'Study object');
isa_ok($study->lanes()->[0], 'Bio::HPS::FastTrack::Lane', 'Lane object');

for my $l(@{$study->lanes()}) {
  $l->pipeline_stage();
}

my $lane = $study->lanes()->[0];
is($lane->study_name, 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is($lane->sample_id, 79, 'Sample ID');
is($lane->processed, 15, 'Processed flag');
is($lane->lane_name, '7138_6#17', 'Lane name');
is($lane->pipeline_stage, 'invalid flag', 'Pipeline Stage');

my $lane2 = $study->lanes()->[1];
is($lane2->pipeline_stage(), 'invalid flag', 'Pipeline Stage');
my $lane3 = $study->lanes()->[2];
is($lane3->pipeline_stage, 'invalid flag', 'Pipeline Stage');
my $lane4 = $study->lanes()->[3];
is($lane4->pipeline_stage, 'import', 'Pipeline Stage');
print Dumper($study);
done_testing();
