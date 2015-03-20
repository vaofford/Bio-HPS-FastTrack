#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::MappingAnalysis');
  }

ok( my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::MappingAnalysis->new( database => 'virus'), 'Creating a MappingAnalysis runner object');
isa_ok ( $mapping_analysis_runner, 'Bio::HPS::FastTrack::PipelineRun::MappingAnalysis', 'PipelineRun module hook' );

done_testing();
