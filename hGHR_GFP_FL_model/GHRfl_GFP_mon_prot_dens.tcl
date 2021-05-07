# Measuring prot dens for GHRfl_GFP monomer m3pws10 sim #


#trajectory#
mol new /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod_f0.gro
mol addfile /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/combined_trj_prot_mem_prod.xtc step 5 waitfor all

## Selection ##

set BB [atomselect top "name BB"]
set prot [atomselect top "not resname POPC"]

vdolmap density $prot -res 1.0 -allframes -combine avg -mol top -checkpoint 0 -o  /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/GHRfl_SP_GFPmon_prot_dens_30us5ns.dx
volmap density $BB  -res 1.0 -allframes -combine avg -mol top -checkpoint 0 -o   /home/raul/remote-home/remote-home/MD-sims/SPTMRs/GHR/CG/GHR_SP_ECDfl_TMD_ICDfl_GFP_composite/productiveMD/results/GHRfl_SP_GFPmon_BB_dens_30us5ns.dx

mol delete all