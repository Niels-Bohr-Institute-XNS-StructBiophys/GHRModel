### Measurement of GHR-D2 angle with respect to z   ###
### and measurement of N-ter to ECD contacts v/time ###
### for the GHRfl-GFP M3pws10 system                ###

package require Orient
namespace import Orient::orient

## D2 angle ##
mol new /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod_f0.gro
mol addfile /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod.xtc step 2 waitfor all

set id [molinfo top]
set num_steps [molinfo $id get numframes]
set out1 [open /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/ECD_D2angle_more_info.dat w]
set out2 [open /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/Nt_ECD_contacts.dat w]
set out3 [open /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/ECD_Nt_contacts.dat w]


for {set f 0} {$f <=  $num_steps} {incr f} {
      #fit TMD-BB
      set all [atomselect top all]
      
      #set ref [atomselect top "resid 250 to 272 and name BB" frame 0]
      #set sel [atomselect top "resid 250 to 272 and name BB"]
      
      set ref [atomselect top "resid 267 to 289 and name BB" frame 0]
      set sel [atomselect top "resid 267 to 289  and name BB"]
      

      set M [measure fit $sel $ref]
      $all move $M
     #get ECD-D2pa
      #set D2 [atomselect top "name BB and resid 129 to 235"]
      set D2 [atomselect top "name BB and resid 146 to 252"]
      
      $D2 frame $f
      set D2pa [draw principalaxes $D2]
      set D2pa_3 [lindex $D2pa 2]
      set projection1xC [lindex $D2pa_3 0]	
  	set projection1yC [lindex $D2pa_3 1] 
  	set projection1zC [lindex $D2pa_3 2]
      set angz [vecdot $D2pa_3 {0 0 1}]
      set anglez [expr 57.2958*acos($angz)]
      set angx [vecdot $D2pa_3 {1 0 0}]
      set anglex [expr 57.2958*acos($angx)]
      puts $out1 "$f $projection1xC $projection1yC $projection1zC $angz $angx $anglez $anglex"
 }
 close $out1
 
 for {set f 0} {$f <=  $num_steps} {incr f} {
	# Nter - ECD contact (dist ≤7 BB-BB)
      #set Ntail [atomselect top "name BB and resid 1 to 32"]
      set Ntail [atomselect top "name BB and resid 1 to 49"]
      #set ECD [atomselect top "name BB and resid 33 to 235"]
      set ECD [atomselect top "name BB and resid 50 to 252"]
      
      #set contact_Ntail_ECD [atomselect top "name BB and resid 1 to 32 and pbwithin 7 of name BB and resid 33 to 235" frame $f]
      #set contact_ECD_Ntail [atomselect top "name BB and resid 33 to 235 and pbwithin 7 of name BB and resid 1 to 32" frame $f ]
      
      set contact_Ntail_ECD [atomselect top "name BB and resid 1 to 49 and pbwithin 7 of name BB and resid 50 to 252" frame $f]
      set contact_ECD_Ntail [atomselect top "name BB and resid 50 to 252 and pbwithin 7 of name BB and resid 1 to 49" frame $f ]

      
      #$contact_Ntail_ECD frame $f
      #$contact_ECD_Ntail frame $f
      puts $out2 "$f [$contact_Ntail_ECD num] [$contact_Ntail_ECD get resid]"
      puts $out3 "$f [$contact_ECD_Ntail num] [$contact_ECD_Ntail get resid]"
}	 

 close $out2
 close $out3
 mol delete all
