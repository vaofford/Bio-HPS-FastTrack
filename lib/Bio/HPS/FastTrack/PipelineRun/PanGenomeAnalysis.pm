package Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $pan_genome_analysis_runner = Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

sub run {

  my ($self) = @_;
  $self->_is_pan_genome_analysis_done();
  
}

sub _is_pan_genome_analysis_done {

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
