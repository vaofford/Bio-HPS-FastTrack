#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis');
  }

ok( my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis->new( database => 'virus'), 'Creating a SNPCallingAnalysis runner object');
isa_ok ( $mapping_analysis_runner, 'Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis', 'PipelineRun module hook' );

done_testing();
