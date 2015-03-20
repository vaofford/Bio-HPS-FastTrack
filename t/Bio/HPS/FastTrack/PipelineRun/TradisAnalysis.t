#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::TradisAnalysis');
  }

ok( my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new( database => 'virus'), 'Creating a TradisAnalysis runner object');
isa_ok ( $mapping_analysis_runner, 'Bio::HPS::FastTrack::PipelineRun::TradisAnalysis', 'PipelineRun module hook' );

done_testing();
