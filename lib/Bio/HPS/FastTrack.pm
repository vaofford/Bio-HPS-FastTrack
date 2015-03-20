package Bio::HPS::FastTrack;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
use File::Temp qw/ tempfile tempdir /;
use File::Path qw(make_path remove_tree);
use Bio::HPS::FastTrack::AnalysisDetector;

has 'study' => ( is => 'rw', isa => 'Str', required => 1);
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', default => sub { ['all'] });
has 'analysis_runners'   => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_analysis_runners');
has 'mode'   => ( is => 'rw', isa => 'Str', default => '' );



sub run {

  my ($self) = @_;
  use Data::Dumper;
  print Dumper($self->analysis_runners());
  

}


sub _build_analysis_runners {
  my ($self) = @_;
  return Bio::HPS::FastTrack::AnalysisDetector->new( analysis => $self->analysis(), database=> $self->database() )->analysis_runners();
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;

