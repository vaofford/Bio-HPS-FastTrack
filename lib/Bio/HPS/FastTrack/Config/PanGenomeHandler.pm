package Bio::HPS::FastTrack::Config::PanGenomeHandler;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
extends('Bio::HPS::FastTrack::Config::ConfigHandler');

has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );

sub _build_analysis_config_handler {

  my ($self) = @_;
  return {};

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
