package Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::Analysis');

sub run {

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
