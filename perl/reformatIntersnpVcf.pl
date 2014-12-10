#!/usr/bin/env perl
use strict;
use warnings;

use vars  qw ($opt_v $opt_p);
use Getopt::Std;
use Data::Dumper;
#local($/) = undef; # dont!
getopts("v:p:");

die "population code (-p) is required" unless $opt_p;
open FILE, $ARGV[0] or die $!;
open VCF, $opt_v or die $!;


my $line = <VCF>;
die "unknown file format: $line\n" unless $line =~ /\#\#fileformat=VCFv4\.1/;
#print $line;

## build vcf index:
my %index=();
print STDERR "building index\n";
while (<VCF>){
  chomp;
  next if /^\s*$/;
  next if /^\s*#/;
  my ($chr, $pos, $id) = /^(\w+)\t([\d]+)\t([\w\d]+)\t/;
 # warn "smth is missing in $chr && $pos && $id\n".substr($_,1,80) unless $chr && $pos && $id;
  chomp($chr); chomp($id); chomp($pos);
  
  $index{$chr}{$id} = $pos;
 }
print STDERR "done, parsing intersnp file\n";

while (<FILE>) {
  chomp;
  next if /^\s*$/;
  next if /^\s*#/;
  my ($chr, $id1, undef, undef,  $id2, undef, undef, $somevalue, $r2, $someflag) = split;
  my ($pos1, $pos2);

  $pos1 = (exists($index{$chr}{$id1})) ?
   $index{$chr}{$id1} : $id1; 
  die "nothing found for $chr, $id1 !" unless $pos1;
  $pos2 = (exists($index{$chr}{$id2})) ?
   $index{$chr}{$id2} : $id2; 
  die "nothing found for $chr, $id2 !" unless $pos2;

 

  printf("%d\t%d\t%s\t%s\t%s\t%f\t%f\t%d\n", ($pos1, $pos2, $opt_p, $id1, $id2, 0, $r2, $someflag) );


}





#print Dumper %index;

__END__
