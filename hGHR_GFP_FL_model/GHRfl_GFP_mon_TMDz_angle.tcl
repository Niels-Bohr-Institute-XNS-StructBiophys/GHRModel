### Measuring TMD-z angle (redo to check) GHRfl_GFP monomer m3pws10 sim ###

package require Orient
namespace import Orient::orient


#trajectory#
mol new /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod_f0.gro
mol addfile /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod.xtc step 2 waitfor all 

set outfile [open /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/GHRfl_SP_GFPmon_TMDz_30us2ns.dat w]
 
set nf [molinfo top get numframes]

#set H1 [atomselect top "name BB and resid 250 to 273"]
set H1 [atomselect top "name BB and resid 267 to 290"]

for {set i 1} {$i <= $nf} {incr i} {
    $H1 frame $i
    
    set I [draw principalaxes $H1]
    set VI [lindex $I 2]
    set VIu [vecscale $VI [expr 1/[veclength $VI]]]
    set VIuz [lindex $VIu 2]
    set H1z [vecdot $VIu {0 0 1}]
    set H1zangle [expr 57.2958*acos($H1z)]
    puts $outfile "$i $VIuz $H1zangle"
}
close $outfile

quit
