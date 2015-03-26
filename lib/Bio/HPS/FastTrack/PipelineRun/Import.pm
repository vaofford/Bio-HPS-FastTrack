package Bio::HPS::FastTrack::PipelineRun::Import;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $import_runner = Bio::HPS::FastTrack::PipelineRun::Import->new(study =>  2027, database => 'pathogen_prok_track_test');

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'imported');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'not imported');
has 'add_to_config_path' => ( is => 'ro', isa => 'Str', default => 'import');


no Moose;
__PACKAGE__->meta->make_immutable;
1;
