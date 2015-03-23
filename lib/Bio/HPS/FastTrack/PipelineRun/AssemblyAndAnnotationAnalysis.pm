package Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $assembly_and_annotation_analysis_runner = Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::Analysis');

sub run {

  my ($self) = @_;
  $self->_is_assembly_and_annotation_done();
}

sub _is_assembly_and_annotation_done {


}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
