package Bio::HPS::FastTrack;

use Moose;
use File::Temp qw/ tempfile tempdir /;
use File::Path qw(make_path remove_tree);

has 'study' => ( is => 'rw', isa => 'Str', required => 1);
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'analysis'   => ( is => 'rw',  isa => 'Maybe[ArrayRef]', default => sub { ['all'] });
has 'mode'   => ( is => 'rw', isa => 'Str', default => '' );
has 'config_file_path'   => ( is => 'rw', isa => 'Str');

sub run {

  my ($self) = @_;

  $self->_create_perliminary_config_file();

}


sub _create_perliminary_config_file {

  my ($self) = @_;

  my $dir = '/Users/js21/hps_fast_track_config';
  my $config_file_path = $dir . '/config_' . $self->study;

  make_path($dir) unless (-d  $dir);
  open(my $fh, ">", $config_file_path);

  print $fh (qq({\n\t'fastTrack' => {\n\t\t));
  print $fh (qq('study' => '), $self->study, "',\n\t\t");
  print $fh (qq('database' => '), $self->database, "',\n\t\t");
  print $fh (qq('analysis' => [\n));
  for my $analysis_type(@{ $self->analysis }) {
    print $fh (qq(\t\t\t\t'$analysis_type',\n));
  }
  print $fh (qq(\t\t\t\t],\n));
  print $fh (qq(}\n));
  $self->config_file_path($config_file_path);
  close($fh);
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

