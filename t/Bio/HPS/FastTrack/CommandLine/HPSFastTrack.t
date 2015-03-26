#!/usr/bin/env perl
use Moose;
use Data::Dumper;
use File::Slurp;
use File::Path qw( remove_tree);
use Cwd;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

BEGIN {
    use Test::Most;
    use_ok('Bio::HPS::FastTrack::CommandLine::HPSFastTrack');
}

my $cwd         = getcwd();
my $script_name = 'Bio::HPS::FastTrack::CommandLine::HPSFastTrack';

local $ENV{PATH} = "$ENV{PATH}:./bin";
my %scripts_and_expected_files;

system('touch empty_file');

%scripts_and_expected_files = (

			       ' -s 2027 -d pathogen_prok_track_test -m test' => 
			       [
				['empty_file', 'empty_file'],
				['/Users/js21/hps_fast_track_config/config_2465'],
			       ],
			       ' -s 2027 -d pathogen_prok_track_test -p rna-seq -m test' => 
			       [
				['empty_file','empty_file']
			       ],
			       ' -s 2027 -d pathogen_prok_track_test -p mapping -p rna-seq -m test' => 
			       [
				['empty_file','empty_file']
			       ],
);

mock_execute_script_and_check_multiple_file_output( $script_name,
    \%scripts_and_expected_files );

cleanup_files();
done_testing();

sub cleanup_files {
  unlink('empty_file');
  #unlink('~/hps_fast_track_config/config_2465');
  #rmdir('~/hps_fast_track_config');
}
