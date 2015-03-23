package Bio::HPS::FastTrack::Lane;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_lane = Bio::HPS::FastTrack::Lane->new(lane_name => $name, sample_id => $sample_id, processed => $processed_flag});

=cut

use Moose;

has 'lane_name'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'sample_id'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'processed'   => ( is => 'rw', isa => 'Int', required => 1 );
has 'study_name'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'pipeline_stage' => ( is => 'rw', isa => 'Str', lazy => 1, builder => '_build_pipeline_stage' );


sub _build_pipeline_stage {

  my ($self) = @_;
  my %flags = (1 => 'import',
	       2 => 'qc',
	       4 => 'mapped',
	       8 => 'stored',
	       16 => 'deleted',
	       32 => 'swapped',
	       64 => 'altered_fastq',
	       128 => 'improved',
	       256 => 'snp_called',
	       512 => 'rna_seq_expression',
	       1024 => 'assembled',
	       2048 => 'annotated',
	      );
  if ( defined $flags{ $self->processed() } && $flags{ $self->processed() } ne '') {
    return($flags{ $self->processed() });
  }
  else {
    return 'invalid flag';
  }
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
