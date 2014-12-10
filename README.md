makeLD
======
A GNU make file to calculate LD from 1000 genomes data (phase 1 release 3).

Depencies
======
These must be installed in your path
  * about 2TB of intermediate diskspace (for all chromosomes)
  * GNU make
  * wget
  * plink
  * vcftools 
  * Perl (>5.8 should do)
  * Intersnp (http://intersnp.meb.uni-bonn.de/)
  * optional need to patch and re-build Intersnp for output of r2 values < 0.5
  * Java (>1.6) to re-format hapmap format to HDF5 format
