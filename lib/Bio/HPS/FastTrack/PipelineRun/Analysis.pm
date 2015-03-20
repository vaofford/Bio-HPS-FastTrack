package Bio::HPS::FastTrack::PipelineRun::Analysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::Analysis->new( database => 'virus')

=cut

use Moose;

has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis_runner' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_analysis_runner');

sub _build_analysis_runner {

  my ($self) = @_;
  return {};

}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
