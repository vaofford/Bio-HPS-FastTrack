package Bio::HPS::FastTrack::VRTrackObject::Study;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

  my $hps_study = Bio::HPS::FastTrack::VRTrackObject::Study->new( id => '123', database => 'pathogen_prok_track_test')

=cut

use Moose;
use DBI;
use File::Slurp;
use Bio::HPS::FastTrack::VRTrackObject::Lane;
use VRTrack::Project;
use Bio::HPS::FastTrack::Exception;
use Bio::HPS::FastTrack::Types::FastTrackTypes;
use Data::Dumper;
extends('Bio::HPS::FastTrack::VRTrackObject::VRTrack');

has 'study' => ( is => 'rw', isa => 'Int', required => 1 );
has 'vrtrack_study' => ( is => 'rw', isa => 'VRTrack::Project', lazy => 1, builder => '_build_vrtrack_study');
has 'lanes' => ( is => 'rw', isa => 'HashRef', lazy => 1, builder => '_build_list_of_lanes_for_study');

sub _build_list_of_lanes_for_study {

  my ($self) = @_;
  $self->_get_lane_data_from_database();
}

sub _build_vrtrack_study {

  my ($self) = @_;
  my $vrtrack_study = VRTrack::Project->new_by_ssid( $self->vrtrack(), $self->study);
  return $vrtrack_study;
}


sub _get_lane_data_from_database {

  my ($self) = @_;
  my %lanes;
  my $study_id = $self->study();
  my $sql = <<"END_OF_SQL";
select la.`name` from latest_lane as la
inner join latest_library as li on (li.`library_id` = la.`library_id`)
inner join latest_sample as s on (s.`sample_id` = li.`sample_id`)
inner join latest_project as p on (p.`project_id` = s.`project_id`)
where p.`ssid` = $study_id
group by la.`name`
order by la.`name`;
END_OF_SQL

  my $dbi_driver = $self->mode() eq 'prod' ? 'DBI:mysql:database=' : 'DBI:SQLite:dbname=';
  my $create_test_db = 't/data/database/create_test_db_and_populate.sql';
  my $destroy_test_db = 't/data/database/create_test_db_and_populate.sql';
  _use_sqllite_test_db($create_test_db) if $self->mode eq 'test';

  my $dsn = $dbi_driver . $self->database() . ';host=' . $self->hostname() . ';port=' . $self->port();
  my $dbh = DBI->connect($dsn, $self->user()) ||
    Bio::HPS::FastTrack::Exception::DatabaseConnection->throw(
							      error => "Error: Could not connect to database '" .
							      $self->database() . "' on host '" .
							      $self->hostname . "' on port '" . $self->port . "'\n"
							     );
  my $sth = $dbh->prepare($sql);
  $sth->execute();
  while (my $ref = $sth->fetchrow_arrayref()) {
    my $lane = Bio::HPS::FastTrack::VRTrackObject::Lane->new(
							     database => $self->database,
							     mode => $self->mode,
							     lane_name => $ref->[0]
							    )->vrlane;
    $lanes{$lane->hierarchy_name} = $lane;
    #push(@lanes, $lane);
  }
  $sth->finish();

  _use_sqllite_test_db($destroy_test_db) if $self->mode eq 'test';
  $dbh->disconnect();

  return \%lanes;
}

sub _use_sqllite_test_db {

  my ($file) = @_;
  my $dsn = 'DBI:SQLite:dbname=t/data/database/test.db';
  my $dbh = DBI->connect($dsn);
  my @sql = read_file($file);
  for my $stmt (@sql) {
    $dbh->do($stmt);
  }
  $dbh->disconnect();
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
