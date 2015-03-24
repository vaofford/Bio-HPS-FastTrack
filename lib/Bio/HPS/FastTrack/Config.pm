package Bio::HPS::FastTrack::Config;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_config = Bio::HPS::FastTrack::Config->new( id => '123', database => 'pathogen_prok_track_test')

=cut

use Moose;
use File::Basename;
use File::Spec;
use Cwd qw/abs_path/;

has 'study_name' => ( is => 'rw', isa => 'Str', required => 1 );
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'db_alias'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'add_to_config_path' => ( is => 'rw', isa => 'Str', required => 1 );
has 'config_root' => ( is => 'rw', isa => 'Str', lazy => 1, default => '/nfs/pathnfs05/conf' );
has 'path_to_high_level_config' => ( is => 'rw', isa => 'Str', lazy => 1, builder => '_build_path_to_high_level_config');

sub _build_path_to_high_level_config {
  
  my ($self) = @_;
  my $high_level_conf_filename = $self->database() . '_' . $self->add_to_config_path() . '_' . 'pipeline.conf';
  
  my $abs_path;
  if( $self->db_alias eq 'no alias' ) {
    $abs_path = abs_path(File::Spec->catfile($self->config_root(), $self->database(), $high_level_conf_filename));
    return $abs_path;
  }
  else {
    $abs_path = abs_path(File::Spec->catfile($self->config_root(), $self->db_alias(), $high_level_conf_filename));
    return $abs_path;
  }
}

sub parse_high_level_config {


}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
