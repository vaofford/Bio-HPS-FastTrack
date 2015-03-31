#!/usr/bin/env perl
use Moose;
use Data::Dumper;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::PipelineRun::Import');
  }

ok( my $import_runner = Bio::HPS::FastTrack::PipelineRun::Import->new( study =>  2027, database => 'pathogen_prok_track_test', mode => 'prod' ), 'Creating a Mapping runner object');


done_testing();
