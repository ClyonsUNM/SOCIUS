
// We assess the statistical significance of changes across models in the 
// coefficients for the HOLC scores using a general framework for comparing 
// marginal effects for nonlinear models developed by Mize, Doan, and Long (2019). 


// Variable choice based on Ex 4.4 Comparing effects on different outcomes; 
// Mize et al. 2019
// see https://www .trentonmize.com/software/mecompare. 
// Code based on above directions**//


clear
clear matrix
capture log close
log using "C:\Users\clyons\Desktop\Redlining\Mize et al tests.log", replace

use "C:\Users\clyons\Desktop\Redlining\HOLC and NNCS2_Socius.dta", clear

drop if t_f4ro10 ==. | t_disd40==.

gen interval2010 = INTERVAL2010

		   
**clone the DV for each model of violent crime and property**

clonevar hrM1 = t_hr2rd
lab var  hrM1 "M1 base model"
clonevar hrM2 = t_hr2rd
lab var  hrM2 "M2 basemodel + control"	
clonevar hrM3 = t_hr2rd
lab var  hrM3 "M3 +segregation v. M2"
clonevar hrM4 = t_hr2rd
lab var  hrM4 "M4 +housing v. M2"
clonevar hrM5 = t_hr2rd
lab var  hrM5 "M5 +disad v. M2"
clonevar hrM6 = t_hr2rd
lab var  hrM6 "M6 full model"

clonevar bM1 = t_bg2rd
lab var  bM1 "M1 base model"
clonevar bM2 = t_bg2rd
lab var  bM2 "M2 basemodel + control"	
clonevar bM3 = t_bg2rd
lab var  bM3 "M3 +segregation v. M2"
clonevar bM4 = t_bg2rd
lab var  bM4 "M4 +housing v. M2"
clonevar bM5 = t_bg2rd
lab var  bM5 "M5 +disad v. M2"
clonevar bM6 = t_bg2rd
lab var  bM6 "M6 full model"	   

set matsize 10000


**Violence

**m1 v m2

gsem (hrM1 <-  i.interval2010  M1[city_id], nbreg exp (t_pop102)) ///
	 (hrM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemvio1_2		
	
	
**m2 v m3	
gsem (hrM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///
	 (hrM3 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 i.nraceth_new2 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemvio2_3	


**m2 v m4	
gsem (hrM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///
	(hrM4 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 t_lgloanhu t_pvac2 t_f4ro10 t_homeown2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemvio2_4	
	
	
**m2 v m5	
gsem (hrM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///	
	(hrM5 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 t_dsdc2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemvio2_5

**m2 v m6
gsem (hrM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///	
	(hrM6 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 i.nraceth_new2 t_lgloanhu t_pvac2 t_f4ro10 t_homeown2 t_dsdc2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 M1[city_id], nbreg exp (t_pop102)),vce(cluster city_id)

	est store gsemvio2_6
	
	
	
**Burgalry
	
**m1 v m2

gsem (bM1 <-  i.interval2010  M1[city_id], nbreg exp (t_pop102)) ///
	 (bM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemburg1_2		
	
	
**m2 v m3	
gsem (bM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///
	 (bM3 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 i.nraceth_new2 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id) 
	
	est store gsemburg2_3	


**m2 v m4	
gsem (bM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///
	(bM4 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 t_lgloanhu t_pvac2 t_f4ro10 t_homeown2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)
	
	est store gsemburg2_4	
	
	
**m2 v m5	
gsem (bM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///	
	(bM5 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 t_dsdc2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) , vce(cluster city_id)
	
	est store gsemburg2_5

**m2 v m6
gsem (bM2 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 c_west2 M1[city_id], nbreg exp (t_pop102)) ///	
	(bM6 <- i.interval2010 t_disd40 t_pcblk40 t_medhv40 t_lnpo22 t_frbr2 t_m5242 i.nraceth_new2 t_lgloanhu t_pvac2 t_f4ro10 t_homeown2 t_dsdc2 c_pop082 c_pblk2 c_phisp2 c_dsdc2 c_pmov52 c_pvac2 c_dswb12 c_south2 M1[city_id], nbreg exp (t_pop102)), vce(cluster city_id)

	est store gsemburg2_6


****************************************************************        
//  Compare marginal effects for multi-category nominal IVs
****************************************************************        

 *make predictions for each HOLC grade and then calculate 
*        differences between grades for average discrete change

*----------------------------
**VIOLENCE
*----------------------------

*Models 1 vs 2**/

est restore gsemvio1_2
margins i.interval2010, post 
qui mlincom 1,   rowname(m1 A) stat(est se p) clear
qui mlincom 2,   rowname(m1 B) stat(est se p) add
qui mlincom 3,   rowname(m1 C) stat(est se p) add
qui mlincom 4,   rowname(m1 D) stat(est se p) add
qui mlincom 5,   rowname(m2 A) stat(est se p) add
qui mlincom 6,   rowname(m2 B) stat(est se p) add
qui mlincom 7,   rowname(m2 C) stat(est se p) add
qui mlincom 8,   rowname(m2 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M1b - M1a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M1c - M1a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M1d - M1a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 1_2) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 1_2) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 1_2) stat(est se p) add twidth(15)


*Models 2 vs to 3**/

est restore gsemvio2_3
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m3 A) stat(est se p) add
qui mlincom 6,   rowname(m3 B) stat(est se p) add
qui mlincom 7,   rowname(m3 C) stat(est se p) add
qui mlincom 8,   rowname(m3 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M3b - M3a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M3c - M3a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M3d - M3a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_3) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_3) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_3) stat(est se p) add twidth(15)


**M2 vs. M4
est restore gsemvio2_4
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m4 A) stat(est se p) add
qui mlincom 6,   rowname(m4 B) stat(est se p) add
qui mlincom 7,   rowname(m4 C) stat(est se p) add
qui mlincom 8,   rowname(m4 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M4b - M4a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M4c - M4a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M4d - M4a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_4) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_4) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_4) stat(est se p) add twidth(15)


**M2 vs. M5
est restore gsemvio2_5
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m5 A) stat(est se p) add
qui mlincom 6,   rowname(m5 B) stat(est se p) add
qui mlincom 7,   rowname(m5 C) stat(est se p) add
qui mlincom 8,   rowname(m5 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M5b - M5a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M5c - M5a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M5d - M5a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_5) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_5) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_5) stat(est se p) add twidth(15)


**M2 vs. M6
est restore gsemvio2_6
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m6 A) stat(est se p) add
qui mlincom 6,   rowname(m6 B) stat(est se p) add
qui mlincom 7,   rowname(m6 C) stat(est se p) add
qui mlincom 8,   rowname(m6 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M6b - M6a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M6c - M6a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M6d - M6a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_6) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_6) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_6) stat(est se p) add twidth(15)

*#########################################
*-------------------------------
***BURGLARY****
*-------------------------------

*Models 1 vs 2*/

est restore gsemburg1_2
margins i.interval2010, post 
qui mlincom 1,   rowname(m1 A) stat(est se p) clear
qui mlincom 2,   rowname(m1 B) stat(est se p) add
qui mlincom 3,   rowname(m1 C) stat(est se p) add
qui mlincom 4,   rowname(m1 D) stat(est se p) add
qui mlincom 5,   rowname(m2 A) stat(est se p) add
qui mlincom 6,   rowname(m2 B) stat(est se p) add
qui mlincom 7,   rowname(m2 C) stat(est se p) add
qui mlincom 8,   rowname(m2 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M1b - M1a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M1c - M1a) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M1d - M1a) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M2c - M2a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M2d - M2a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 1_2) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 1_2) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 1_2) stat(est se p) add twidth(15)



*Models 2 vs  3**/

est restore gsemburg2_3
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m3 A) stat(est se p) add
qui mlincom 6,   rowname(m3 B) stat(est se p) add
qui mlincom 7,   rowname(m3 C) stat(est se p) add
qui mlincom 8,   rowname(m3 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - Ma) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - Ma) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M3b - M3a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M3c - M3a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M3d - M3a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_3) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_3) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_3) stat(est se p) add twidth(15)


**M2 vs. M4
est restore gsemburg2_4
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m4 A) stat(est se p) add
qui mlincom 6,   rowname(m4 B) stat(est se p) add
qui mlincom 7,   rowname(m4 C) stat(est se p) add
qui mlincom 8,   rowname(m4 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - Ma) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - Ma) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M4b - M4a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M4c - M4a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M4d - M4a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_4) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_4) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_4) stat(est se p) add twidth(15)


**M2 vs. M5
est restore gsemburg2_5
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m5 A) stat(est se p) add
qui mlincom 6,   rowname(m5 B) stat(est se p) add
qui mlincom 7,   rowname(m5 C) stat(est se p) add
qui mlincom 8,   rowname(m5 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - Ma) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - Ma) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M5b - M5a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M5c - M5a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M5d - M5a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_5) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_5) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_5) stat(est se p) add twidth(15)



**M2 vs. M6
est restore gsemburg2_6
margins i.interval2010, post 
qui mlincom 1,   rowname(m2 A) stat(est se p) clear
qui mlincom 2,   rowname(m2 B) stat(est se p) add
qui mlincom 3,   rowname(m2 C) stat(est se p) add
qui mlincom 4,   rowname(m2 D) stat(est se p) add
qui mlincom 5,   rowname(m6 A) stat(est se p) add
qui mlincom 6,   rowname(m6 B) stat(est se p) add
qui mlincom 7,   rowname(m6 C) stat(est se p) add
qui mlincom 8,   rowname(m6 D) stat(est se p) add


qui mlincom (2-1), rowname(Diff in ADCs: M2b - M2a) stat(est se p) add
qui mlincom (3-1), rowname(Diff in ADCs: M2c - Ma) stat(est se p) add
qui mlincom (4-1), rowname(Diff in ADCs: M2d - Ma) stat(est se p) add
qui mlincom (6-5), rowname(Diff in ADCs: M6b - M6a) stat(est se p) add
qui mlincom (7-5), rowname(Diff in ADCs: M6c - M6a) stat(est se p) add 
qui mlincom (8-5), rowname(Diff in ADCs: M6d - M6a) stat(est se p) add

qui mlincom (2-1) - (6-5), rowname (BA Gap m 2_6) stat(est se p) add
qui mlincom (3-1) - (7-5), rowname(CA Gap m 2_6) stat(est se p) add
mlincom (4-1) - (8-5), rowname(DA Gap m 2_6) stat(est se p) add twidth(15)






