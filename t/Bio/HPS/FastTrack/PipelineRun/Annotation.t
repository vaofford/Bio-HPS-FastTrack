#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Annotation');
  }

ok( my $annotation_runner = Bio::HPS::FastTrack::PipelineRun::Annotation->new( study =>  2027, database => 'pathogen_prok_track_test' ), 'Creating a Annotation runner object');
isa_ok ( $annotation_runner, 'Bio::HPS::FastTrack::PipelineRun::Annotation', 'PipelineRun module hook' );
ok ( my $study = $annotation_runner->study_metadata(), 'Creating study object');
isa_ok ( $study, 'Bio::HPS::FastTrack::Study');
ok ( $study->lanes(), 'Collecting lanes');

$annotation_runner->run();

isa_ok ($study->lanes()->[0], 'Bio::HPS::FastTrack::Lane');
is( $study->lanes()->[0]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name');
is( $study->lanes()->[0]->sample_id(), 79, 'Sample ID');
is( $study->lanes()->[0]->processed(), 15, 'Processed flag');
is( $study->lanes()->[0]->lane_name(), '7138_6#17', 'Lane name');
is( $study->lanes()->[0]->pipeline_stage(), 'not annotated', 'Pipeline stage annotated');

is( $study->lanes()->[1]->study_name(), 'Comparative_RNA_seq_analysis_of_three_bacterial_species', 'Study name annotated2');
is( $study->lanes()->[1]->sample_id(), 76, 'Sample ID annotated2');
is( $study->lanes()->[1]->processed(), 1035, 'Processed flag annotated2');
is( $study->lanes()->[1]->lane_name(), '7153_1#20', 'Lane name annotated2');
is( $study->lanes()->[1]->pipeline_stage(), 'not annotated', 'Pipeline stage annotated2');

done_testing();
