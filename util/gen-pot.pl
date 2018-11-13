#! /bin/perl

#use strict;
use warnings;
use autodie;

if ($#ARGV < 1)
{
    print "Needs two file names as arguments\n";
    exit;
}

local $/ = "";

open my $Cfile, "<$ARGV[0]";
open my $defile, "<$ARGV[1]";
@Cparagraphs = <$Cfile>;
@deparagraphs = <$defile>;

#print $Cparagraphs[1] . "\n";
#print $deparagraphs[1] . "\n";

foreach $i (0 .. $#Cparagraphs) {
    my @Cpar = split "\n", $Cparagraphs[$i];
    my @depar = split "\n", $deparagraphs[$i];

    #print "Msgid $i:\n";
    foreach $Cline (@Cpar)
    {
        print "$Cline\n" unless ($Cline =~ /^msgstr.*/);
    }

    foreach $deline (@depar)
    {
        next unless ($deline =~ /^msgid.*/);
        my $demsgstr = $deline =~ s/^msgid/msgstr/r;
        print $demsgstr . "\n";
    }
    print "\n";
}
