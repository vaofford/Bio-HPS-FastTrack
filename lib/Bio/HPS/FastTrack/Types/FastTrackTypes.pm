package Bio::HPS::FastTrack::Types::FastTrackTypes;

# ABSTRACT: Special types for the HPS-FastTrack system

=head1 SYNOPSIS


=cut

use Moose::Util::TypeConstraints;


subtype 'RunMode',
  as 'Str',
  where { validate_run_mode($_) },
  message { "Invalid run mode - '$_' -" };

sub validate_run_mode {

  my ($mode) = @_;
  return 1 if ($mode eq 'prod' or $mode eq 'test');
  return 0;
}


subtype 'LaneStoragePath',
  as 'Str',
  where { validate_storage_path($_) },
  message { "This path '$_' does not exist in this filesystem -" };


sub validate_storage_path {

  my ($storage_path) = @_;
  if ($storage_path eq 'no storage path retrieved') {
    return 1;
  }
  else {
    if ( -e $storage_path ) {
      return 1;
    }
    return 0;
  }
}

subtype 'VRLane',
  as 'Maybe[Object]',
  where { validate_vrlane($_) },
  message { "Invalid vrlane - '$_' -" };

sub validate_vrlane {

  my ($vrlane) = @_;
  if ( eval { $vrlane->can("processed") } ) {
    return 1;
  }
  else {
    return 1 if ($vrlane->{status} eq 'lane not found in tracking database');
  }
  return 0;
}

subtype 'VRProject',
  as 'Maybe[Object]',
  where { validate_vrproject($_) },
  message { "Invalid vrproject - '$_' -" };

sub validate_vrproject {

  my ($vrproject) = @_;
  if ( eval { $vrproject->can("study_id") } ) {
    return 1;
  }
  else {
    return 1 if ($vrproject->{status} eq 'study not found in tracking database');
  }

  return 0;
}
