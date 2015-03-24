#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Analysis');
  }

ok( my $analysis_runner = Bio::HPS::FastTrack::PipelineRun::Analysis->new( study =>  2027, database => 'pathogen_prok_track_test' ), 'Creating a Analysis runner object');
isa_ok ( $analysis_runner, 'Bio::HPS::FastTrack::PipelineRun::Analysis', 'PipelineRun module hook' );
is ( $analysis_runner->allowed_processed_flags()->{1}, 'import', 'Import flag');
is ( $analysis_runner->allowed_processed_flags()->{2}, 'qc', 'QC flag');
ok ( my $study = $analysis_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::Study');
ok ( $study->lanes(), 'Collecting lanes');
isa_ok ($study->lanes()->[0], 'Bio::HPS::FastTrack::Lane');
is( $study->lanes()->[0]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is( $study->lanes()->[0]->sample_id(), 79, 'Sample ID');
is( $study->lanes()->[0]->processed(), 15, 'Processed flag');
is( $study->lanes()->[0]->lane_name(), '7138_6#17', 'Lane name');

print Dumper($analysis_runner);
done_testing();
