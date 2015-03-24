package Bio::HPS::FastTrack::PipelineRun::SNPCalling;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $snp_calling_runner = Bio::HPS::FastTrack::PipelineRun::SNPCalling->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'flag_to_check'   => ( is => 'ro', isa => 'Str', default => 'snp_called');

sub run {

  my ($self) = @_;
  $self->_is_snp_calling_done();
  
}

sub _is_snp_calling_done {

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
