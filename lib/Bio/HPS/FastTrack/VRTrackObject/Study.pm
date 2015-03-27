package Bio::HPS::FastTrack::VRTrackObject::Study;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

  my $hps_study = Bio::HPS::FastTrack::VRTrackObject::Study->new( id => '123', database => 'pathogen_prok_track_test')

=cut

use Moose;
use DBI;
use File::Slurp;
use Bio::HPS::FastTrack::VRTrackObject::Lane;
use VRTrack::Study;
use Bio::HPS::FastTrack::Exception;
use Bio::HPS::FastTrack::Types::FastTrackTypes;
extends('Bio::HPS::FastTrack::VRTrackObject::VRTrack');

has 'study' => ( is => 'rw', isa => 'Int', required => 1 );
#has 'lanes' => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_list_of_lanes_for_study');
has 'vrtrack_study' => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_vrtrack_study_object');
has 'study_name' => ( is => 'rw', isa => 'Str', lazy => 1, default => 'NA' );

sub _build_list_of_lanes_for_study {
  my ($self) = @_;
  $self->_get_lane_data_from_database();
}

sub _build_vrtrack_study_object {

  my ($self) = @_;
  my $study_obj = VRTrack::Study->new( $self->vrtrack(), $self->study);
  return $study_obj;

}

sub _get_lane_data_from_database {

  my ($self) = @_;
  $self->vrtrack();
  


}

sub _get_lane_data_from_database_old {
  my ($self) = @_;
  my @lanes;
  my $study_id = $self->study();
  my $sql = <<"END_OF_SQL";
select la.`name`, s.`sample_id`, la.`processed`, p.`hierarchy_name`, la.`storage_path` from latest_lane as la
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
							     lane_name => $ref->[0],
							     sample_id => $ref->[1],
							     processed => $ref->[2],
							     study_name => $ref->[3],
							     storage_path => defined $ref->[4] && $ref->[4] ne '' ? $ref->[4] : 'no storage path retrieved'
							    );
    push(@lanes, $lane);
  }
  $sth->finish();
  
  _use_sqllite_test_db($destroy_test_db) if $self->mode eq 'test';
  $dbh->disconnect();
  $self->study_name($lanes[0]->study_name());
  return \@lanes;
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
