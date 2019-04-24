#!/usr/bin/perl

use strict;
use warnings;

use Cwd;
use Getopt::Long;

my $dir = getcwd;
my $javaArgs = " -cp $dir";

#   params: engineCount | enginePath | scanParameter
sub writeSettingsFile($$$)
{
    my ($engineCount, $filePath, $parameter) = $_;
    my $settingsData = "";

    for my $i (0 .. $engineCount) {
        my $engineName = "[TestEngine$i]\n";
        my $enginePath = "path=\"$filePath\"\n";
        my $scanParameter = "scan_parameter=\"$parameter\"\n";
        $settingsData += $engineName . $enginePath . $scanParameter;
    }
}

#   params: filePath | data
sub writeToFile($$)
{
    my ($filePath, $data) = $_;

    printf "Started writing $filePath";

    open(handle, '>', $filePath) or die $!;
    print handle $data;
    close(handle);

    printf "Settings file written";
}



