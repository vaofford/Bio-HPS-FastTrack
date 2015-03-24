package Bio::HPS::FastTrack::PipelineRun::Mapping;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $mapping_runner = Bio::HPS::FastTrack::PipelineRun::Mapping->new( database => 'pathogen_prok_track_test');

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'mapped');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'not mapped');




no Moose;
__PACKAGE__->meta->make_immutable;
1;
