package  Bio::HPS::FastTrack::SetPipeline;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $analysis_detector = Bio::HPS::FastTrack::SetPipelines->new( database => 'virus', analysis => ['all'])

=cut

use Moose;
use Bio::HPS::FastTrack::PipelineRun::PipelineRun;
use Bio::HPS::FastTrack::PipelineRun::Mapping;
use Bio::HPS::FastTrack::PipelineRun::Assembly;
use Bio::HPS::FastTrack::PipelineRun::Annotation;
use Bio::HPS::FastTrack::PipelineRun::SNPCalling;
use Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis;
use Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis;
use Bio::HPS::FastTrack::PipelineRun::TradisAnalysis;

has 'study'   => ( is => 'rw', isa => 'Int', required => 1 );
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'pipeline'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', required => 1);
has 'pipeline_runners'   => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_pipeline_runners');


sub _build_pipeline_runners {

  my ($self) = @_;

  my @runners;
  if ( scalar @{ $self->pipeline() } == 0 ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::PipelineRun->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'mapping' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Mapping->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'assembly' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Assembly->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'annotation' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Annotation->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'snp-calling' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::SNPCalling->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'rna-seq' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'pan-genome' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'tradis' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new(study => $self->study(), database => $self->database() ) );
  }
  if ( 'all' ~~ @{ $self->pipeline() } ) {
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Mapping->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Assembly->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::Annotation->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::SNPCalling->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::PanGenomeAnalysis->new(study => $self->study(), database => $self->database() ) );
    push( @runners, Bio::HPS::FastTrack::PipelineRun::TradisAnalysis->new(study => $self->study(), database => $self->database() ) );    
  }


    
  return \@runners;
      
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
