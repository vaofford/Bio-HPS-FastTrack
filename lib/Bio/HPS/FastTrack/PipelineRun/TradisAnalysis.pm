package Bio::HPS::FastTrack::PipelineRun::TradisAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $tradis_analysis_runner = Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

sub run {

  my ($self) = @_;
  $self->_is_tradis_analysis_done();
  
}

sub _is_tradis_analysis_done {

  
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
