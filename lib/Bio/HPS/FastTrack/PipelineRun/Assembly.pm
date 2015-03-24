package Bio::HPS::FastTrack::PipelineRun::Assembly;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $assembly_runner = Bio::HPS::FastTrack::PipelineRun::Assembly->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'assembled');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'not assembled');


no Moose;
__PACKAGE__->meta->make_immutable;
1;
