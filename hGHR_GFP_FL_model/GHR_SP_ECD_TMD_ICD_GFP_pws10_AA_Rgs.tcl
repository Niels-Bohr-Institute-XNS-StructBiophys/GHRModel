set out1 [open /home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/BME/GHR_SP_ECD_TMD_ICD_GFPpws10_Rg_05useq_comb.dat w]

#for {set i 100} {$i <= 6003} {incr i} {
#mol new ../Data_eq1us/AA_frame_ae_$i.pdb
#set all [atomselect top all]
#set rg1 [measure rgyr $all]
#puts $out1 "$rg1"
#}

#for {set i 100} {$i <= 6003} {incr i} {
set files [glob -directory "/home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/Data_eq0d5_comb/" -- "*.pdb"]
set sorted [lsort -dictionary $files]
foreach i $sorted {
        mol new $i
        #set all [atomselect top all]
        #set rg1 [measure rgyr $all]
        set all     [atomselect top "protein "] 
        set ECDfl   [atomselect top "protein and resid 1 to 252"] 
        set ICD_gfp [atomselect top "protein and resid 313 to 863"] 
        set ICD     [atomselect top "protein and resid 313 to 639"] 

        $all frame $i
        $ECDfl frame $i
        $ICD frame $i
        $ICD_gfp frame $i

        set allRg     [measure rgyr $all]
        set ECDflRg   [measure rgyr $ECDfl]
        set ICDRg     [measure rgyr $ICD]
        set ICD_gfpRg [measure rgyr $ICD_gfp]

        puts $out1 "$allRg $ECDflRg $ICDRg $ICD_gfpRg "
        #puts $out1 "$i $rg1"
        mol delete all
}
mol delete all
close $out1

quit


 
 
