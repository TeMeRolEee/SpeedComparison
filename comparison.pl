#!/usr/bin/perl

use strict;
use warnings;

use Cwd;
use Getopt::Long;

my $dir = getcwd;
my $javaArgs = " -cp $dir";
my $javaProjectName = undef;

my $cPlusProjectName = undef;

GetOptions (
    "javaName=s"    => \$javaProjectName,
    "cPlusName=s"   => \$cPlusProjectName
) or die ("Error in command line arguments\n");

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
    writeToFile("$dir\\ $javaProjectName", $settingsData);
    writeToFile("$dir\\ $cPlusProjectName", $settingsData);
}

#   params: filePath | data
sub writeToFile($$)
{
    my ($filePath, $data) = $_;

    printf "Started writing $filePath";

    open(HANDLE, '>', $filePath) or die $!;
    print HANDLE $data;
    close(HANDLE);

    printf "Settings file written";
}

writeSettingsFile(20, "C:\TC_ARTIFACTS\SpeedComparison\6\Testengine\TestEngines.exe", "-s");

