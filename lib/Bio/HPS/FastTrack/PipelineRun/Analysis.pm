package Bio::HPS::FastTrack::PipelineRun::Analysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::Analysis->new( database => 'virus')

=cut

use Moose;
use Bio::HPS::FastTrack::Study;

has 'study' => ( is => 'rw', isa => 'Int', required => 1);
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis_runner' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_analysis_runner');

sub _build_analysis_runner {

  my ($self) = @_;
  return {};

}

sub run {


  

}

sub _get_study_and_lanes {


}

sub _has_completed {


}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
