package Bio::HPS::FastTrack::PipelineRun::PipelineRun;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_analysis_runner = Bio::HPS::FastTrack::PipelineRun::PipelineRun->new( database => 'pathogen_prok_track_test')

=cut

use Moose;
use Bio::HPS::FastTrack::VRTrackObject::Study;
use Bio::HPS::FastTrack::Config;
use Bio::HPS::FastTrack::Exception;

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'NA');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'NA');
has 'add_to_config_path' => ( is => 'ro', isa => 'Str', default => 'NA');

has 'allowed_processed_flags' => ( is => 'rw', isa => 'HashRef', default => sub { {} });
has 'study' => ( is => 'rw', isa => 'Int', lazy => 1, default => '' );
has 'lane' => ( is => 'rw', isa => 'Str', lazy => 1, default => '');
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'mode'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'pipeline_runner' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_pipeline_runner' );
has 'db_alias' => ( is => 'rw', isa => 'Str', lazy => 1, builder => '_build_db_alias' );
has 'study_metadata' => ( is => 'rw', isa => 'Bio::HPS::FastTrack::Study', lazy => 1, builder => '_build_study_metadata') ;
has 'lane_metadata' => ( is => 'rw', isa => 'Bio::HPS::FastTrack::Lane', lazy => 1, builder => '_build_lane_metadata') ;
has 'config_data' => ( is => 'rw', isa => 'Bio::HPS::FastTrack::Config', lazy => 1, builder => '_build_config_data') ;

sub BUILD {

  my ($self) = @_;
  $self->allowed_processed_flags($self->_allowed_processed_flags());

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

sub _build_db_alias {

  my ($self) = @_;
  my %database_aliases = (
				'pathogen_virus_track'    => 'viruses',
				'pathogen_prok_track'     => 'prokaryotes',
				'pathogen_euk_track'      => 'eukaryotes',
				'pathogen_helminth_track' => 'helminths',
				'pathogen_rnd_track'      => 'rnd'
			       );
  
  if ( $database_aliases{$self->database()} ) {
    return( $database_aliases{$self->database()} );
  }
  else {
    return( 'no alias' );
  }
}

sub _build_pipeline_runner {

  my ($self) = @_;
  return {};

}

sub _build_study_metadata {

  my ($self) = @_;
  my $study = Bio::HPS::FastTrack::Study->new( study => $self->study(), database => $self->database(), mode => $self->mode  );
  $study->lanes();
  return $study;
}

sub _build_lane_metadata {

  my ($self) = @_;
  my $study = Bio::HPS::FastTrack::Lane->new(  lane_name => $self->lane(), database => $self->database(), mode => $self->mode  );
  $study->lanes();
  return $study;
}

sub _build_config_data {

  my ($self) = @_;
  my $config = Bio::HPS::FastTrack::Config->new(
						study_name => $self->study_metadata()->study_name(),
						database => $self->database(),
						db_alias => $self->db_alias(),
						add_to_config_path => $self->add_to_config_path(),
						mode => $self->mode()
					       );  
  return $config;

}

sub run {

  my ($self) = @_;
  $self->_is_pipeline_stage_done();
  
}

sub _is_pipeline_stage_done {

  my ($self) = @_;
  my $study_lanes = $self->study_metadata()->lanes();
  for my $lane(@$study_lanes) {
    if( ($lane->processed() & $self->allowed_processed_flags()->{$self->stage_done}) == 0 ) {
      $lane->pipeline_stage($self->stage_not_done);
    }
    else {
      $lane->pipeline_stage($self->stage_done);
    }
  }

}



no Moose;
__PACKAGE__->meta->make_immutable;
1;
