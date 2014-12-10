makeLD
======
A GNU make file to calculate LD from 1000 genomes data (phase 1 release 3).

Depencies
==========
These must be installed in your path
  * about 2TB of intermediate diskspace (for all chromosomes)
  * GNU make
  * wget
  * plink
  * vcftools 
  * Perl (>5.8 should do)
  * Intersnp 1.4 (http://intersnp.meb.uni-bonn.de/)
  * optional need to patch and re-build Intersnp for output of r2 values < 0.5
  * Java (>1.6) to re-format hapmap format to HDF5 format

Patching Intersnp
==========

Intersnp by default doesn't allow to controll the r2 cutoff for generating the LD file, it is either all, but with more columns or 0.5. The patch in patch/intersnp-r2.patch allows to choose the r2 cutoff by defining a value in the intersnp control file sfile.txt. Setting DOHAPFILE to a value [0,1[ and it will be used as a cutoff.
 > DOHAPFILE 0.1
