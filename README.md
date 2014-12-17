makeLD
======
A GNU make file to calculate LD from 1000 genomes data (phase 1 release 3).
Note: I have no clue if that could work for other phases or how to adapt the code. Just drop me a note if you find it out.

Dependencies
==========
The binaries must be installed in your path
  * about 2TB of intermediate diskspace (for all chromosomes)
  * GNU make
  * wget
  * plink
  * vcftools (http://vcftools.sourceforge.net/)
  * Perl (>5.8 should do)
  * Intersnp 1.4 (http://intersnp.meb.uni-bonn.de/)
  * optional need to patch and re-build Intersnp for output of r2 values < 0.5
  * Java (>1.6) to re-format hapmap format to HDF5 format

Patching Intersnp
==========

Intersnp by default doesn't allow to controll the r2 cutoff for generating the LD file, it is either all, but with more columns or 0.5. The patch in patch/intersnp-r2.patch allows to choose the r2 cutoff by defining a value in the intersnp control file sfile.txt. Setting DOHAPFILE to a value [0,1[ and it will be used as a cutoff.

`DOHAPFILE 0.1`

To apply the patch:
 * Download and extract Intersnp into a local directory:
 * `wget http://intersnp.meb.uni-bonn.de/INTERSNP_1.14.zip`
 * `unzip INTERSNP_1.14.zip`
 * apply the patch:
 * `patch -p1  < patch/intersnp-r2.patch`
 * compile a serial version of Intersnp
 * `cd INTERSNP_1.14; g++ intersnp.cpp -o intersnp -O3`
 * install the binary in your path, e.g.
 * `install -D intersnp $HOME/bin`

Running the LD calculations
==========
 * clone this repository into the directory you want to do the calculations in
 * copy the perl files to a directory where they are in your path
 * carefully inspect Makefile.in such that you agree with any settings and parameters found there
 * adjust parameters by editing Makefile.in, e.g. the population code or mirror
 * `make setup` creates the working directories, one per chromosome
 * test run: `cd 22; make intersnp` to generate hapmap output from intersnp for chromosome 22 to test if it works
 * if you want to run calculation in parallel, you can use `make -j n` from the installation dir, but beware:
 * you should hot have more than 4 parallel downloads from the default mirror, therefore:
 * `make -j4 download` in the root directory of your checkout first, this can take a few days
 * after this is finished without error,run `make -j 24 intersnp`
 * you need to run this via screen or nohup, because it runs for several days
 
Converting hapmap output to HDF5 format
===========
HDF5 is a highly flexible and efficient format to store large data (~2.2GB, all chromosomes at r2 cutoff >= 0.2).
Conversion from Hapmap format to HDF5 format is done via a Java application. The java sources are here: https://github.com/mdondrup/ld2hdf5 need to install HDF5 sys-libraries on the local computer.
Execute the conversion from the root directory where you ran make setup. Good Luck!

 
 






