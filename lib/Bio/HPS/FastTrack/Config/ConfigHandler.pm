package Bio::HPS::FastTrack::Config::ConfigHandler;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;

has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'config_analysis' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_analysis_config_handler');

sub _build_analysis_config_handler {

  my ($self) = @_;
  return {};

}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
