#!/usr/bin/env perl
use Moose;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::AnalysisDetector');
  }

ok( my $analysis_detector = Bio::HPS::FastTrack::AnalysisDetector->new( database => 'virus', analysis => ['all']), 'Creating a AnalysisDetector object');
isa_ok ( $analysis_detector, 'Bio::HPS::FastTrack::AnalysisDetector', 'AnalysisDetector module hook' );
is (scalar @{$analysis_detector->analysis_runners()}, 6, 'All analysis will be run');
isa_ok ( $analysis_detector->analysis_runners()->[0], 'Bio::HPS::FastTrack::PipelineRun::MappingAnalysis', 'PipelineRun module hook' );
isa_ok ( $analysis_detector->analysis_runners()->[1], 'Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis', 'PipelineRun module hook' );
isa_ok ( $analysis_detector->analysis_runners()->[2], 'Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis', 'PipelineRun module hook' );
isa_ok ( $analysis_detector->analysis_runners()->[3], 'Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis', 'PipelineRun module hook' );
isa_ok ( $analysis_detector->analysis_runners()->[4], 'Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis', 'PipelineRun module hook' );
isa_ok ( $analysis_detector->analysis_runners()->[5], 'Bio::HPS::FastTrack::PipelineRun::TradisAnalysis', 'PipelineRun module hook' );

done_testing();
