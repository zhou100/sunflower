gen specialty_crop = apples+cherries+peppers+broccoli+tomatoes+asparagus+caneberries+garlic+carrots+squash+strawberries+cantaloupes+cabbage+plums+lettuce+onions+other_tree_crops+peaches+pomegranates+misc_veg+blueberries+nectarines+radishes+tobacco+peas+cucumbers+pears+honeydew+apricots+cauliflower+eggplants+potatoes+gourds+turnips+prunes
gen specialty_crop1=apples+cherries+peppers+broccoli+tomatoes+asparagus+caneberries+garlic+carrots
gen hort_notrees=peppers+broccoli+tomatoes+asparagus+celery+garlic+carrots+squash+cantaloupes+cabbage+lettuce+onions+misc_veg+radishes+tobacco+peas+cucumbers+honeydew+cauliflower+eggplants+potatoes+sweet_potatoes+gourds+turnips
gen totcitrus=oranges+citrus
gen treefruit=apples+cherries+plums+prunes+pears+peaches+nectarines+apricots+other_tree+pomegranates
gen berries=caneberries+blueberries+strawberries+cranberries
gen treenuts=almonds+walnuts+pecans
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
gen lncitrus=ln(totcitrus+1)
gen lntreefruit=ln(treefruit+1)
gen lntreenuts=ln(treenuts+1)
gen lnberries=ln(berries+1)
gen lnhort=ln(hort+1)
gen lnnature=ln(naturalarea+1)
gen lndeveloped=ln(developed_agg+1)

gen plant_lncorn=plantcorn*lncorn
gen plant_lnsoy=plantsoy*lnsoy
gen plant_lnwwht=plantwinwht*lnwwht
gen plant_lnalfalfa=planthay*lnalfalfa
gen plant_lnohay=planthay*lnohay



global FC `"corn soybeans winter_wheat other_hay alfalfa"'
global SC `"totcitrus tree* berries hort"'
global lnFC `"lncorn lnsoy lnwwht lnohay lnalfalfa"'
global lnSC `"lncitrus lntree* lnberries lnhort"'
global P `"plant_corn plant_soy plant_wwht plant_a"'
global N `"agg_forest agg_shrub agg_grassland agg_wetland developed_agg"'
global FE `"i.region i.month i.year"'
global W `"average_mintemp average_precip"'

cd  "C:\Users\baylis.UOFI\Dropbox\Current\Guyu\Fungicide\"

**complete regression
xi: reg nosema $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall winter pollination, robust
outreg2 using "nosema1.xls"
xi: reg lnnosema1 $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall winter pollination, robust
outreg2 using "nosema1.xls"
xi: logit nosema_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"

xi: reg mites $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination, robust
outreg2 using "nosema1.xls"
xi: reg lnmites1 $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination, robust
outreg2 using "nosema1.xls"

xi: logit abpv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W region2 region3 region6 i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"
xi: logit abpv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"
xi: logit bqcv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"
xi: logit dwv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.region i.year spring fall pollination lnmites1, robust
mfx
outreg2 using "nosema1.xls"
xi: logit cbpv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W region2 i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"
xi: logit iapv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W region6 spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"
xi: logit kbv_d $lnFC plant_ln* $lnSC lnalmonds lndeveloped $W i.year spring fall pollination, robust
mfx
outreg2 using "nosema1.xls"

***Just specialty crops
xi: reg nosema $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
xi: reg lnnosema1 $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
xi: logit nosema_d $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
mfx
xi: reg mites $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
xi: reg lnmites1 $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
xi: logit abpv_d $lnSC lnalmonds lndeveloped $W i.region i.year spring fall migratory, robust
mfx
xi: logit bqcv_d $lnSC lnalmonds lndeveloped $W i.region i.year spring fall, robust
mfx
xi: logit dwv_d $lnSC lnalmods lndeveloped $W i.region i.year spring fall lnmites1, robust
mfx
xi: logit cbpv_d $lnSC lndeveloped $W region2 i.year, robust
mfx
xi: logit iapv_d $lnSC lndeveloped $W i.region i.year spring fall lnmites1, robust
mfx
xi: logit kbv_d $lnSC lndeveloped $W i.year spring fall, robust
mfx


*note that when we include NDVI, the months are no longer significant
xi: reg nosema corn soybeans plantcorn plantsoy average_veg $N $W i.region i.year yr*, cluster(region)

xi: reg nosema $FC $P $N $W average_veg i.region i.year, cluster(region)


xi: reg mites $FC $P $SC $N $W $FE
xi: reg nosema $FC $P $N $W $FE, robust
xi: reg nosema $FC $P $SC $N $W i.month i.region i.year
xi: reg nosema $FC $SC $W $FE, robust

***
xi: reg nosema $FC naturalarea developed_agg $W $FE yr*
xi: reg nosema $SC naturalarea developed_agg $W $FE yr*
xi: reg nosema $FC $P $SC naturalarea developed_agg $W $FE
xi: reg lnnosema $FC $P $SC naturalarea developed_agg $W $FE yr*
xi: logit nosema_d $FC $P $SC naturalarea developed_agg $W $FE
xi: reg mites $FC $P $SC naturalarea developed_agg $W lnndvi $FE
xi: reg lnmites $FC $P $SC naturalarea developed_agg $W $FE
xi: logit abpv_d $FC $P $SC naturalarea developed_agg $W $FE
xi: logit bqcv_d $FC $P $SC naturalarea developed_agg $W $FE
xi: logit dwv_d $FC $P $SC naturalarea developed_agg $W $FE mites
xi: logit cbpv_d $FC $P $SC naturalarea developed_agg $W $FE
xi: logit iapv_d $FC $P $SC naturalarea developed_agg $W $FE
xi: logit kbv_d $FC $P $SC naturalarea developed_agg $W $FE

xi: reg abpv_d $FC $P $SC naturalarea developed_agg $W i.region yr*
xi: logit bqcv_d $FC $P $SC naturalarea developed_agg $W i.region yr*
xi: logit dwv_d $FC $P $SC naturalarea developed_agg $W i.region yr*
xi: logit cbpv_d $FC $P $SC naturalarea developed_agg $W i.region yr*
xi: logit iapv_d $FC $P $SC naturalarea developed_agg $W i.region yr*
xi: logit kbv_d $FC $P $SC naturalarea developed_agg $W i.region yr*


gen region1=1 if region==1
gen region2=1 if region==2
gen region3=1 if region==3
gen region4=1 if region==4
gen region5=1 if region==5
gen region6=1 if region==6
gen region7=1 if region==7
recode region* (.=0)
gen mo_reg1=region1*month
gen mo_reg2=region2*month
gen mo_reg3=region3*month
gen mo_reg4=region4*month
gen mo_reg5=region5*month
gen mo_reg6=region6*month

gen yr_reg1=region1*(year-2008)
gen yr_reg2=region2*(year-2008)
gen yr_reg3=region3*(year-2008)
gen yr_reg4=region4*(year-2008)
gen yr_reg5=region5*(year-2008)
gen yr_reg6=region6*(year-2008)


reg 
