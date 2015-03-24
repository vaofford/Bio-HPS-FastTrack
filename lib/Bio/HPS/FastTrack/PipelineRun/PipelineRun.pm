package Bio::HPS::FastTrack::PipelineRun::PipelineRun;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::PipelineRun->new( database => 'pathogen_prok_track_test')

=cut

use Moose;
use Bio::HPS::FastTrack::Study;

has 'allowed_processed_flags' => ( is => 'rw', isa => 'HashRef', default => sub { {} });
has 'study' => ( is => 'rw', isa => 'Int', required => 1);
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'pipeline_runner' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_pipeline_runner' );
has 'study_metadata' => ( is => 'rw', isa => 'Bio::HPS::FastTrack::Study', lazy => 1, builder => '_build_study_metadata') ;

sub BUILD {

  my ($self) = @_;
  $self->allowed_processed_flags($self->_allowed_processed_flags());

}

sub _build_pipeline_runner {

  my ($self) = @_;
  return {};

}


sub _build_study_metadata {

  my ($self) = @_;
  my $study = Bio::HPS::FastTrack::Study->new(study => $self->study(), database => $self->database() );
  return $study;

}

sub _allowed_processed_flags {

  my ($self) = @_;

  my %flags = (import => 1,
	       qc => 2,
	       mapped => 4,
	       stored => 8,
	       deleted => 16,
	       swapped => 32,
	       altered_fastq => 64,
	       improved => 128,
	       snp_called => 256,
	       rna_seq_expression => 512,
	       assembled  => 1024,
	       annotated  => 2048,
	      );
 
  return \%flags;
}



no Moose;
__PACKAGE__->meta->make_immutable;
1;
