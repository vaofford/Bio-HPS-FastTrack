#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::SetPipeline');
  }

ok( my $pipeline = Bio::HPS::FastTrack::SetPipeline->new( study => '123', database => 'virus', pipeline => ['all']), 'Creating a SetPipeline object');
isa_ok ( $pipeline, 'Bio::HPS::FastTrack::SetPipeline', 'SetPipeline module hook' );
is (scalar @{$pipeline->pipeline_runners()}, 7, 'All pipelines will be run');
isa_ok ( $pipeline->pipeline_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::Mapping', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[1], 'Bio::HPS::FastTrack::PipelineRun::Assembly', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[2], 'Bio::HPS::FastTrack::PipelineRun::Annotation', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[3], 'Bio::HPS::FastTrack::PipelineRun::SNPCalling', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[4], 'Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[5], 'Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis', 'PipelineRun module hook' );
isa_ok ( $pipeline->pipeline_runners()->[6], 'Bio::HPS::FastTrack::PipelineRun::TradisAnalysis', 'PipelineRun module hook' );

done_testing();
