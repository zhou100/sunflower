**HQ cropscape
gen HQ0=1 if hq==0
gen HQ1=1 if hq>0&<500
gen HQ2=1 if hq>=500&hq<1000
gen HQ3=1 if hq>=1000
recode HQ* (.=0)
replace HQ0=. if hq==.
replace HQ1=. if hq==.
replace HQ2=. if hq==.
replace HQ3=. if hq==.
sum agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa ///
spec_crop almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.
sum agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa ///
spec_crop almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if HQ0==1
sum agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa ///
spec_crop almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if HQ1==1
sum agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa ///
spec_crop almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if HQ2==1
sum agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa ///
spec_crop almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if HQ3==1

ttest agg_forest, by(HQ0)
ttest agg_shrub, by(HQ0)
ttest agg_grassland, by(HQ0)
ttest agg_wetland, by(HQ0)
ttest agg_developed, by(HQ0)
ttest corn, by(HQ0)
ttest soybeans, by(HQ0)
ttest winter_wheat, by(HQ0)
ttest other_hay, by(HQ0)
ttest alfalfa, by(HQ0)
ttest spec_crop, by(HQ0)
ttest almonds, by(HQ0)
ttest citrustot, by(HQ0)
ttest walnuts, by(HQ0)
ttest watermelon, by(HQ0)
ttest pecans, by(HQ0)
ttest apples, by(HQ0)
ttest cranberries, by(HQ0)
ttest blueberries, by(HQ0)
ttest grapes, by(HQ0)
ttest plumtot, by(HQ0)
ttest peas, by(HQ0)
ttest potatoes, by(HQ0)
ttest cherries, by(HQ0)
ttest cabbage, by(HQ0)
ttest cucumbers, by(HQ0)
ttest tomatoes, by(HQ0)
ttest tobacco, by(HQ0)
ttest pumpkin, by(HQ0)
ttest strawberries, by(HQ0)
ttest squash, by(HQ0)
ttest peaches, by(HQ0)
ttest greens, by(HQ0)
ttest onions, by(HQ0)
ttest sweet_p, by(HQ0)
ttest pistachio, by(HQ0)
ttest pears, by(HQ0)
ttest asparagus, by(HQ0)
ttest peppers, by(HQ0)
ttest cantaloupe, by(HQ0)
ttest lettuce, by(HQ0)

gen HQ01=HQ0+HQ1

ttest agg_forest, by(HQ01)
ttest agg_shrub, by(HQ01)
ttest agg_grassland, by(HQ01)
ttest agg_wetland, by(HQ01)
ttest agg_developed, by(HQ01)
ttest corn, by(HQ01)
ttest soybeans, by(HQ01)
ttest winter_wheat, by(HQ01)
ttest other_hay, by(HQ01)
ttest alfalfa, by(HQ01)
ttest spec_crop, by(HQ01)
ttest almonds, by(HQ01)
ttest citrustot, by(HQ01)
ttest walnuts, by(HQ01)
ttest watermelon, by(HQ01)
ttest pecans, by(HQ01)
ttest apples, by(HQ01)
ttest cranberries, by(HQ01)
ttest blueberries, by(HQ01)
ttest grapes, by(HQ01)
ttest plumtot, by(HQ01)
ttest peas, by(HQ01)
ttest potatoes, by(HQ01)
ttest cherries, by(HQ01)
ttest cabbage, by(HQ01)
ttest cucumbers, by(HQ01)
ttest tomatoes, by(HQ01)
ttest tobacco, by(HQ01)
ttest pumpkin, by(HQ01)
ttest strawberries, by(HQ01)
ttest squash, by(HQ01)
ttest peaches, by(HQ01)
ttest greens, by(HQ01)
ttest onions, by(HQ01)
ttest sweet_p, by(HQ01)
ttest pistachio, by(HQ01)
ttest pears, by(HQ01)
ttest asparagus, by(HQ01)
ttest peppers, by(HQ01)
ttest cantaloupe, by(HQ01)
ttest lettuce, by(HQ01)

gen HQ999=1 if hq<1000
replace HQ999=0 if hq>999&hq~=.

ttest agg_forest, by(HQ999)
ttest agg_shrub, by(HQ999)
ttest agg_grassland, by(HQ999)
ttest agg_wetland, by(HQ999)
ttest agg_developed, by(HQ999)
ttest corn, by(HQ999)
ttest soybeans, by(HQ999)
ttest winter_wheat, by(HQ999)
ttest other_hay, by(HQ999)
ttest alfalfa, by(HQ999)
ttest spec_crop, by(HQ999)
ttest almonds, by(HQ999)
ttest citrustot, by(HQ999)
ttest walnuts, by(HQ999)
ttest watermelon, by(HQ999)
ttest pecans, by(HQ999)
ttest apples, by(HQ999)
ttest cranberries, by(HQ999)
ttest blueberries, by(HQ999)
ttest grapes, by(HQ999)
ttest plumtot, by(HQ999)
ttest peas, by(HQ999)
ttest potatoes, by(HQ999)
ttest cherries, by(HQ999)
ttest cabbage, by(HQ999)
ttest cucumbers, by(HQ999)
ttest tomatoes, by(HQ999)
ttest tobacco, by(HQ999)
ttest pumpkin, by(HQ999)
ttest strawberries, by(HQ999)
ttest squash, by(HQ999)
ttest peaches, by(HQ999)
ttest greens, by(HQ999)
ttest onions, by(HQ999)
ttest sweet_p, by(HQ999)
ttest pistachio, by(HQ999)
ttest pears, by(HQ999)
ttest asparagus, by(HQ999)
ttest peppers, by(HQ999)
ttest cantaloupe, by(HQ999)
ttest lettuce, by(HQ999)


gen lnhq=ln(hq)
gen lnhq1=ln(hq+1)
reg lnhq1 agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa spec_crop
xi: reg lnhq1 agg_forest agg_shrub agg_grassland agg_wetland agg_developed corn soybeans winter_wheat other_hay alfalfa spec_crop i.region i.year i.month


gen developed_agg=developed_o+developed_l+developed_m+developed_h
gen naturalarea=agg_forest+agg_shrub+agg_grass+agg_wet

gen plant_corn=corn*plantcorn
gen plant_soy=plantsoy*soybeans
gen plant_wwht=plantwinwht*winter_w
gen planthay=plantcorn+plantwinwht
gen plant_ohay=planthay*other_hay
gen plant_alfalfa=planthay*alfalfa

gen lncorn=ln(corn+1)
gen lnsoy=ln(soybeans+1)
gen lnwwht=ln(winter_wheat+1)
gen lnalfalfa=ln(alfalfa+1)
gen lnohay=ln(other_hay+1)
gen lncitrus=ln(citrustot+1)
gen lnspec_crops=ln(spec_crop+1)
gen lnnature=ln(naturalarea+1)
gen lndeveloped=ln(developed_agg+1)

reg lnhq1 lnnature lndeveloped lncorn lnsoy lnwwht lnohay lnalfalfa lnspec_crop lncitrus

ttest spec_crop, by(HQ0) 

gen HQ_=HQ1+2*HQ2+3*HQ3
xi: ologit HQ_ lnnature lndeveloped lncorn lnsoy lnwwht lnohay lnalfalfa lnspec_crop lncitr lntree* i.month i.year
outreg2 using "HQ1.xls"
xi: reg lnhq lnnature lndeveloped lncorn lnsoy lnwwht lnohay lnalfalfa lnspec_crop lncitr lntree* i.month i.year
outreg2 using "HQ1.xls"

drop lnhq_hat
predict lnhq_hat
xi: reg lnhq1 lnnature lndeveloped lncorn lnsoy lnwwht lnohay lnalfalfa lnspec_crop lncitr lntree* i.month i.year
outreg2 using "HQ1.xls"

****Reg by cropscape***
gen HQ23=HQ2+HQ3
reg agg_forest HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg agg_shrub HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg agg_grassland HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg agg_wetland HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg agg_developed HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg corn HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg soybeans HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg winter_wheat HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg spring_wheat HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg other_hay HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg alfalfa HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg cotton HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg sorghum HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg spec_crop HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg oranges HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg apple HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg almonds HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg citrus HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg walnuts HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23
reg tomatoes HQ0 HQ1 HQ23, noconstant
test HQ0=HQ1
test HQ1=HQ23


gen lnfungi=ln(fungi+1)
xi: reg lnmites lnfungi i.month i.year
xi: reg lnnosema1 hq hq2 migratory i.month i.year
xi: reg nosema HQ1 HQ23 migratory i.month i.year
xi: reg nosema HQ1 HQ23 mites migratory i.month i.year
xi: reg lnnosema1 HQ1 HQ23 mites migratory i.month i.year
xi: reg lnnosema1 lnnature lndeveloped lncorn lnsoy lnwwht lnohay lnalfalfa lnspec_crop i.month i.year
xi: reg lnnosema1 lnhq_hat1 migratory i.month i.year
outreg2 using "HQ2.xls"
xi: reg lnmites1 lnhq_hat1 migratory i.month i.year
outreg2 using "HQ2.xls"
