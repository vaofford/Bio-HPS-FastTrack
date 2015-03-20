package Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::Analysis');


no Moose;
__PACKAGE__->meta->make_immutable;
1;
