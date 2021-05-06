#!/bin/sh

for i in *.pdb ; do Pepsi-SAXS $i  SAXSdata/ECD_3p45mgmL_subtracted_rebinned_divide_conc.dat -n 32 -ms 0.75 -o pepsi_fits_5000_3p45_q0d75/3p45_"$i"_q075avp.dat > pepsi_fits_5000_3p45_q0d75/logs/3p45_"$i"_q075avp.log ; done 
