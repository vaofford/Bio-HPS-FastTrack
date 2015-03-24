package Bio::HPS::FastTrack::PipelineRun::Assembly;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $assembly_runner = Bio::HPS::FastTrack::PipelineRun::Assembly->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'flag_to_check'   => ( is => 'ro', isa => 'Str', default => 'assembled');

sub run {

  my ($self) = @_;
  $self->_is_assembly_done();
}

sub _is_assembly_done {


}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
