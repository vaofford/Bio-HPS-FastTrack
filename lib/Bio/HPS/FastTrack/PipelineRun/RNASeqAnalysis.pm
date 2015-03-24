package Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis;

# ABSTRACT: Fast track high priority samples through the Pathogen Informatics pipelines

=head1 SYNOPSIS

my $rna_seq_runner = Bio::HPS::FastTrack::PipelineRun::RNASeqAnalysis->new( database => 'virus')

=cut

use Moose;
extends('Bio::HPS::FastTrack::PipelineRun::PipelineRun');

has 'flag_to_check'   => ( is => 'ro', isa => 'Str', default => 'rna_seq_expression');

sub run {

}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
