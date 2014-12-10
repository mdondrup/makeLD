SUBDIRS = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y


setup: 
	for i in $(SUBDIRS); \
        do \
                echo ========= preparing $$i ; \
                (mkdir -p $$i ; cp -v ./Makefile.in $$i/Makefile ; cp -v ./sfile.txt $$i/sfile.txt ) ; \
        done

$(SUBDIRS)::
	$(MAKE) -C $@ $(MAKECMDGOALS)

all clean intersnp hapmapFormat.txt download plink realclean: $(SUBDIRS)

#.DEFAULT: 
#	for i in $(SUBDIRS); \
#        do \
#                echo ========= Making in $$i ; \
#                (cd $$i ; $(MAKE) -$(MAKEFLAGS) $@ ) ; \
#        done


