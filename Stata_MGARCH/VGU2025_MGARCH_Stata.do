clear all
* obtain risk free rate
use "C:\Users\mehdi\Documents\vgu 2025\tbill.dta", clear

merge 1:1 period using "C:\Users\mehdi\Documents\vgu 2025\SANDP_GE.dta"

gen dates = tm(1934m1) + _n - 1
format %tm dates
tsset dates

drop daten period _merge

keep if tin(2010m1,)

gen erge = (r_GE - TB3MS/12) * 100
gen esandp = (r__GSPC - TB3MS/12) * 100

reg erge esandp, ro

asreg erge esand, wind(dates 25)

mgarch ccc (erge esandp =, arch(1/1) garch(1/1)) 

predict Hccc*, variance

gen b_ccc = Hccc_esandp_erge / Hccc_esandp_esandp


mgarch dcc (erge esandp =, arch(1/1) garch(1/1)) 

predict Hdcc*, variance

gen b_dcc = Hdcc_esandp_erge / Hdcc_esandp_esandp

twoway line b_dcc b_ccc _b_esandp dates, name(all)
