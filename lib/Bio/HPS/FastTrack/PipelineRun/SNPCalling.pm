package Bio::HPS::FastTrack::PipelineRun::SNPCalling;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $snp_calling_runner = Bio::HPS::FastTrack::PipelineRun::SNPCalling->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'stage_done'   => ( is => 'ro', isa => 'Str', default => 'snp_called');
has 'stage_not_done'   => ( is => 'ro', isa => 'Str', default => 'not snp_called');

no Moose;
__PACKAGE__->meta->make_immutable;
1;
