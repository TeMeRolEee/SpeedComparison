#!/usr/bin/perl

use strict;
use warnings;

use Cwd;
use Getopt::Long;
use File::Path;
use JSON::Parse;

my $dir = getcwd;
my $javaArgs = " -cp $dir";
my $javaProjectName = undef;
my $cPlusProjectName = undef;
my $enginePathParameter = undef;
my $engineCount = 8; #   Default is 8 because YOLO (Your only length's OKTA)

sub printUsage
{
    print "The parameters of the script are mandatory!\n";
    print "\t-javaName=JavaProjectName\n";
    print "\t-cPlusName=cPlusProjectName\n";
    print "\t-engine=enginePathParameter\n";
    print "\t-engineCount=engineCount\n";

    return;
}

GetOptions(
    "javaName=s"    => \$javaProjectName,
    "cPlusName=s"   => \$cPlusProjectName,
    "engine=s"      => \$enginePathParameter,
    "engineCount=i" => \$engineCount
) or die("Error in command line arguments\n");

END {
    #   print "$javaProjectName $cPlusProjectName $enginePathParameter\n";
}

$SIG{'INT'} = sub {END};

die(printUsage) unless ($javaProjectName && $cPlusProjectName && $enginePathParameter);

#   params: engineCount | enginePath | scanParameter
sub writeSettingsFile($$)
{
    my ($filePath, $parameter) = @_;
    my $settingsData = "";
    for my $i (0 .. $engineCount) {
        my $engineName = "[TestEngine$i]\n";
        my $enginePath = "path=\"$filePath\"\n";
        my $scanParameter = "scan_parameter=\"$parameter\"\n";
        $settingsData .= $engineName . $enginePath . $scanParameter;
    }

    writeToFile("$dir/$javaProjectName/com/company/settings/settings.ini", $settingsData);
    writeToFile("$dir/$cPlusProjectName/settings/settings.ini", $settingsData);
}

#   params: filePath | data
sub writeToFile($$)
{
    my ($filePath, $data) = @_;

    printf "Started writing $filePath\n";

    open(my $HANDLE, '>', $filePath) or die $!;
    print $HANDLE $data;
    close($HANDLE);

    printf "Settings file written";
}

writeSettingsFile($enginePathParameter, "-s");

