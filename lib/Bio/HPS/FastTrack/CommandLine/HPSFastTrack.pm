package Bio::HPS::FastTrack::CommandLine::HPSFastTrack;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS


=cut

use Moose;
use Getopt::Long qw(GetOptionsFromArray);
use Bio::HPS::FastTrack;
use Bio::HPS::FastTrack::Types::FastTrackTypes;

has 'args'        => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has 'script_name' => ( is => 'ro', isa => 'Str',      required => 1 );
has 'help'        => ( is => 'rw', isa => 'Bool',     default  => 0 );

has 'study' => ( is => 'rw', isa => 'Str');
has 'lane' => ( is => 'rw', isa => 'Str');
has 'database'   => ( is => 'rw', isa => 'Str');
has 'pipeline'   => ( is => 'rw', isa => 'Maybe[ArrayRef]', default => sub { ['all'] } );
has 'mode'   => ( is => 'rw', isa => 'RunMode', default => 'prod' );

sub BUILD {

    my ($self) = @_;

    my ( $study, $lane, $database, $pipeline, $mode, $help );

    GetOptionsFromArray(
			$self->args,
			's|study:s' => \$study,
			'l|lane:s' => \$lane,
			'd|db=s'   => \$database,
			'p|pipeline=s@' =>\$pipeline,
			'm|mode:s' =>\$mode,
			'h|help'           => \$help,
    );

    $self->study($study) if ( defined($study) );
    $self->lane($lane) if ( defined($lane) );
    $self->database($database)     if ( defined($database) );
    $self->pipeline($pipeline)     if ( defined($pipeline) );
    $self->mode($mode) if ( defined($mode) );

}

sub run {
    my ($self) = @_;

    ( ($self->study || $self->lane) && $self->database && $self->pipeline ) or die <<USAGE;
	
Usage:
  -s|study         <>
  -l|lane          <>
  -d|database      <>
  -a|pipeline      <> 
  -h|help          <print this message>

Utility script to fast track high priority samples through the Pathogen Informatics pipelines


USAGE

    my $hps_fast_track = Bio::HPS::FastTrack->new(
						  study => $self->study,
						  lane => $self->lane,
						  database   => $self->database,
						  pipeline => $self->pipeline,
						  mode => $self->mode,
						 );

    $hps_fast_track->run;
   

}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
