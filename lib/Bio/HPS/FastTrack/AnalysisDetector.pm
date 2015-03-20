package  Bio::HPS::FastTrack::AnalysisDetector;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
use Bio::HPS::FastTrack::PipelineRun::Analysis;
use Bio::HPS::FastTrack::PipelineRun::MappingAnalysis;
use Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis;
use Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis;
use Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis;
use Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis;
use Bio::HPS::FastTrack::PipelineRun::TradisAnalysis;


has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', required => 1);
has 'analysis_runners'   => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_analysis_runners');


sub _build_analysis_runners {

  my ($self) = @_;

  my @runners;
  if ( scalar @{ $self->analysis } == 0 ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Analysis->new( database => $self->database() ) );
  }
  if ( 'mapping' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::MappingAnalysis->new( database => $self->database() ) );
  }
  if ( 'assembly' ~~ @{ $self->analysis() } || 'annotation' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis->new( database => $self->database() ) );
  }
  if ( 'snp-calling' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis->new( database => $self->database() ) );
  }
  if ( 'rna-seq' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new( database => $self->database() ) );
  }
  if ( 'pan-genome' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new( database => $self->database() ) );
  }
  if ( 'tradis' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new( database => $self->database() ) );
  }
  if ( 'all' ~~ @{ $self->analysis() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::MappingAnalysis->new( database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::AssemblyAndAnnotationAnalysis->new( database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::SNPCallingAnalysis->new( database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new( database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new( database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new( database => $self->database() ) );    
  }


    
  return \@runners;
      
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
