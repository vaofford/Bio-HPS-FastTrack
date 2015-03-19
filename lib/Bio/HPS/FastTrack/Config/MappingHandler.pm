package Bio::HPS::FastTrack::Config::MappingHandler;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
extends('Bio::HPS::FastTrack::Config::ConfigHandler');


sub _build_analysis_config_handler {

  my ($self) = @_;
  return {};

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
