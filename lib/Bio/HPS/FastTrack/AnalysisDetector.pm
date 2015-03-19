package  Bio::HPS::FastTrack::AnalysisDetector;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
use Bio::HPS::FastTrack::Config::ConfigHandler;
use Bio::HPS::FastTrack::Config::MappingHandler;
use Bio::HPS::FastTrack::Config::AssemblyAndAnnotationHandler;
use Bio::HPS::FastTrack::Config::SNPCallingHandler;
use Bio::HPS::FastTrack::Config::RNASeqHandler;
use Bio::HPS::FastTrack::Config::PanGenomeHandler;
use Bio::HPS::FastTrack::Config::TradisHandler;


has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', required => 1);
has 'analysis_config_handler'   => ( is => 'rw', isa => 'Bio::HPS::FastTrack::Config::ConfigHandler', lazy => 1, builder => '_build_analysis_config_handler');


sub _build_analysis_config_handler {

  my ($self) = @_;

  if ( 'mapping' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::MappingHandler->new( database => $self->database() );
  }
  if ( 'assembly' ~~ @{ $self->analysis() } || 'annotation' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::AssemblyAndAnnotationHandler->new( database => $self->database() );
  }
  if ( 'snp-calling' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::SNPCallingHandler->new( database => $self->database() );
  }
  if ( 'rna-seq' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::RNASeqHandler->new( database => $self->database() );
  }
  if ( 'pan-genome' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::PanGenomeHandler->new( database => $self->database() );
  }
  if ( 'tradis' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::TradisHandler->new( database => $self->database() );
  }
  if ( 'all' ~~ @{ $self->analysis() } ) {
    return Bio::HPS::FastTrack::Config::ConfigHandler->new( database => $self->database() );
  }

}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
