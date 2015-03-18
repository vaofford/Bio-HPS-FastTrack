package Bio::HPS::FastTrack::CommandLine::HPSFastTrack;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
use Getopt::Long qw(GetOptionsFromArray);
use Bio::HPS::FastTrack;

has 'args'        => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has 'script_name' => ( is => 'ro', isa => 'Str',      required => 1 );
has 'help'        => ( is => 'rw', isa => 'Bool',     default  => 0 );

has 'study' => ( is => 'rw', isa => 'Str');
has 'database'   => ( is => 'rw', isa => 'Str');
has 'analysis'   => ( is => 'rw', isa => 'Maybe[ArrayRef]', default => sub { ['all'] } );
has 'mode'   => ( is => 'rw', isa => 'Str', default => '' );

sub BUILD {

    my ($self) = @_;

    my ( $study, $database, $analysis, $mode, $help );

    GetOptionsFromArray(
			$self->args,
			's|study=s' => \$study,
			'd|db=s'   => \$database,
			'a|analysis=s@' =>\$analysis,
			'm|mode:s' =>\$mode,
			'h|help'           => \$help,
    );

    $self->study($study) if ( defined($study) );
    $self->database($database)     if ( defined($database) );
    $self->analysis($analysis)     if ( defined($analysis) );
    $self->mode($mode) if ( defined($mode) );

}

sub run {
    my ($self) = @_;

    ( $self->study && $self->database && $self->analysis ) or die <<USAGE;
	
Usage:
  -s|study         <>
  -d|database      <>
  -a|analysis      <> 
  -h|help          <print this message>

Utility script to fast track high priority samples through the Pathogen Informatics pipelines


USAGE

    my $hps_fast_track = Bio::HPS::FastTrack->new(
				      study => $self->study,
				      database   => $self->database,
				      analysis => $self->analysis,
				      mode => $self->mode,
				     );

    $hps_fast_track->run;
   

}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
