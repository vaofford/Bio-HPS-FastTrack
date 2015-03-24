package Bio::HPS::FastTrack::PipelineRun::Annotation;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $annotation_runner = Bio::HPS::FastTrack::PipelineRun::Annotation->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'annotated');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'not annotated');

no Moose;
__PACKAGE__->meta->make_immutable;
1;
