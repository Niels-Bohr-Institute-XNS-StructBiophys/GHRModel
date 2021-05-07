package require Orient
namespace import Orient::orient

set out1 [open /home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/BME/GHR_SP_ECD_TMD_ICD_GFPpws10_TMDtilt_05useq_comb.dat w]
set out2 [open /home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/BME/GHR_SP_ECD_TMD_ICD_GFPpws10_D2anglez_05useq_comb.dat w]

set files [glob -directory "/home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/Data_eq0d5_comb/" -- "*.pdb"]
set sorted [lsort -dictionary $files]


foreach i $sorted {
    mol new /home/raul/projects/GHR_FL/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/ensemble_fit_copy/r4fit/Data_eq0d5_comb/AA_frame_ae_0.pdb
    set ref [atomselect top "resid 267 to 290 and name CA"]
    mol new $i
    set all [atomselect top all]
    set H1 [atomselect top "name CA and resid 267 to 290"]
    $H1 frame $i
    set I [draw principalaxes $H1]
    set VI [lindex $I 2]
    set VIu [vecscale $VI [expr 1/[veclength $VI]]]
    set VIuz [lindex $VIu 2]
    set H1z [vecdot $VIu {0 0 1}]
    set H1zangle [expr 57.2958*acos($H1z)]
    puts $out1 "$i $VIuz $H1zangle"

    $all frame $i
    set M [measure fit $H1 $ref]
    $all move $M
    #get ECD-D2pa
    set D2 [atomselect top "name CA and resid 146 to 252"]
      
    $D2 frame $i
    set D2pa [draw principalaxes $D2]
    set D2pa_3 [lindex $D2pa 2]
    set projection1xC [lindex $D2pa_3 0]	
  	set projection1yC [lindex $D2pa_3 1] 
  	set projection1zC [lindex $D2pa_3 2]
    set angz [vecdot $D2pa_3 {0 0 1}]
    set anglez [expr 57.2958*acos($angz)]
    set angx [vecdot $D2pa_3 {1 0 0}]
    set anglex [expr 57.2958*acos($angx)]
    puts $out2 "$i $angz $angx $anglez $anglex"

    mol delete all
}

mol delete all
close $out1
close $out2

quit