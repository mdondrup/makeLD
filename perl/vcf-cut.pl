#!/usr/bin/env perl
use strict;
use warnings;

use vars  qw ($opt_c);
use Getopt::Std;
#local($/) = undef; # dont!
getopts("c:");

open FILE, $ARGV[0] or die $!;
open FILTER, $opt_c or die $!;

my @filter = <FILTER>; # get the columns
close FILTER;

my $line = <FILE>;
die "unknown file format: $line\n" unless $line =~ /\#\#fileformat=VCFv4\.1/;
print $line;

## parse header:
my @cols = ();
while (<FILE>){
  next if /^\s*$/;
  if (/^##/) {
  print $_;
  } elsif (/^#CHROM/) {
    #print $_;
    @cols = split;
    last;
  } else {
    die "unknown entry $_\n";
  }
}
#print STDERR @cols, "\n";
my @select = (0..8);
my $i = 0;
my %search = map {($_,$i++)} @cols;


foreach my $l (@filter) {
  chomp $l;
  #print "'$l' -> ", $search{$l},"\n";
  push @select, $search{$l};
}
#print STDERR join(",", @select), "\n";
#print "\n";
print join("\t",@cols[@select]);
print "\n";

while (<FILE>) {
  chomp;
  next if /^\s*$/;
  next if /^\#/;
  @cols = split;
  print join ("\t",@cols[@select]), "\n";

}
