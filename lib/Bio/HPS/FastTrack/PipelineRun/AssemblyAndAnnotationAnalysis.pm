package Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::Analysis');

sub _build_analysis_runner {

  my ($self) = @_;
  return {};

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
