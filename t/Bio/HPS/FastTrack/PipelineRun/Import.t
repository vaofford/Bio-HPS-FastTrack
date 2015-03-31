#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Import');
  }

ok( my $import_runner = Bio::HPS::FastTrack::PipelineRun::Import->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a Mapping runner object');
isa_ok ( $import_runner, 'Bio::HPS::FastTrack::PipelineRun::Import' );
ok ( $import_runner->study_metadata(), 'Creating study object');
isa_ok ( $import_runner->study_metadata(), 'Bio::HPS::FastTrack::VRTrackWrapper::Study');
ok ( $import_runner->study_metadata()->lanes(), 'Collecting lanes');

$import_runner->run();
isa_ok ($import_runner->study_metadata()->lanes()->{'7153_1#20'}, 'VRTrack::Lane');

print Dumper($import_runner);

done_testing();
