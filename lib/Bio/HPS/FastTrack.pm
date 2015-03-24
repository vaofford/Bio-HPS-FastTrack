package Bio::HPS::FastTrack;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_fast_track_bacteria_mapping_and_rna_seq =  Bio::HPS::FastTrack->new( study => '4562', database => 'bacteria', pipeline => ['mapping','rna-seq'] );
$hps_fast_track_bacteria_mapping_and_rna_seq->study();
$hps_fast_track_bacteria_mapping_and_rna_seq->database();
for my $pipeline_run( @{ hps_fast_track_bacteria_mapping_and_rna_seq->pipeline_runners() } ) {
  $pipeline_run->run();
}



=cut

use Moose;
use File::Temp qw/ tempfile tempdir /;
use File::Path qw(make_path remove_tree);
use Bio::HPS::FastTrack::SetPipeline;

has 'study' => ( is => 'rw', isa => 'Int', required => 1);
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'pipeline'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', default => sub { [] });
has 'pipeline_runners'   => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_pipeline_runners');
has 'mode'   => ( is => 'rw', isa => 'Str', default => '' );

sub run {

  my ($self) = @_;

  for my $module(@{$self->pipeline_runners()}) {
    print($module->database(),"\n");

  }
  

}

sub _build_pipeline_runners {
  my ($self) = @_;
  return Bio::HPS::FastTrack::SetPipeline->new( study => $self->study(), pipeline => $self->pipeline(), database=> $self->database() )->pipeline_runners();
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

