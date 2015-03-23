package Bio::HPS::FastTrack::Study;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $hps_study = Bio::HPS::FastTrack::Study->new( id => '123', database => 'pathogen_prok_track_test')

=cut

use Moose;
use DBI;
use Bio::HPS::FastTrack::Lane;

has 'study' => ( is => 'rw', isa => 'Int', required => 1 );
has 'database'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'hostname' => ( is => 'rw', isa => 'Str', lazy => 1, default => 'mcs11' ); #Test database at the moment, when in production change to 'mcs17'
has 'port' => ( is => 'rw', isa => 'Int', lazy => 1, default => '3346' ); #Test port at the moment, when in production change to '3347'
has 'user' => ( is => 'rw', isa => 'Str', lazy => 1, default => 'pathpipe_ro' );
has 'lanes' => ( is => 'rw', isa => 'ArrayRef', lazy => 1, builder => '_build_list_of_lanes');


sub _build_list_of_lanes {

  my ($self) = @_;
  $self->_get_lane_data_from_database();
  

}


sub _get_lane_data_from_database {

  my ($self) = @_;
  my @lanes;
  my $study_id = $self->study();
  my $sql = <<"END_OF_SQL";
select la.`name`, s.`sample_id`, la.`processed`, p.`hierarchy_name`, p.`ssid` from lane as la 
inner join library as li on (li.`library_id` = la.`library_id`)
inner join sample as s on (s.`sample_id` = li.`sample_id`)
inner join project as p on (p.`project_id` = s.`project_id`)
where p.`ssid` = $study_id
and la.`latest` = 1
group by la.`name`
order by la.`name`;
END_OF_SQL

  my $dsn = 'DBI:mysql:database=' . $self->database() . ';host=' . $self->hostname() . ';port=' . $self->port();
  my $dbh = DBI->connect($dsn, $self->user());
  my $sth = $dbh->prepare($sql);
  $sth->execute();
  while (my $ref = $sth->fetchrow_hashref()) {
    my $lane = Bio::HPS::FastTrack::Lane->new(lane_name => $ref->{'name'}, sample_id => $ref->{'sample_id'}, processed => $ref->{'processed'}, study_name => $ref->{'hierarchy_name'});
    push(@lanes, $lane);
  }
  $sth->finish();
  $dbh->disconnect();
  return \@lanes;
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
