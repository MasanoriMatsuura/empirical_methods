clear

** please change your path
global do = "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\do"
global log = "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\log"
global rawdata = "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\rawdata"
global workdata = "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\workdata"
global pic = "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\pic"
*/


capture log close
log using "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\log\reg", replace text
set more off

use "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\Class_Data\rawdata\cps_2014_16.dta",replace

** generate a dummy indicating those get bachelors degree or above
gen college = educ99>= 15

** incwage = 9999999 means missing in data, we need to replace it to "."
replace incwage=. if incwage==9999999

** generate log(incwage)
gen log_incwage = log(incwage)

reg incwage college i.health age year i.race, vce(robust) 
** creates newvar containing linear prediction xb for whole sample
predict incwage_hat 

** creates newvar containing the standard error of the linear prediction xb  
predict incwage_hat_std, stdp 
order incwage incwage_hat incwage_hat_std

reg incwage college i.health age year i.race if sex==1, vce(robust)
** Obtain linear prediction for male (if sex==1) 
predict incwage_hat_m if e(sample)


log close
