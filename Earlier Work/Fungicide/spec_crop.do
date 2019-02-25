**do-file to explore area of specialty crops near contaminated apiaries
*first, some simple aggregation
gen citrustot=orange+citrus 
gen plumtot=plum+prunes
gen spec_crop= asparagus+peaches+lettuce+plum+ peppers+ citrustot+ walnuts+ pistachios+ almonds+ cherries+ tomatoes+ onions+ apples+ pecans+ watermelons+ cabbage+ cantaloupes+ strawberries+ squash+ blueberries+ peas+ carrots+ tobacco+ nectarines+ radishes+ sweet_potatoes+ cucumbers+ caneberries+ pears+ garlic+ honeydew_melons+ broccoli+ apricots+ cauliflower+ celery+ eggplants+ gourds+ turnips+ cranberries+greens+potatoes
*first, ID largest specialty crops near tested apiaries
*(in order - top 25)
sum almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.
sum almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.
sum almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.
sum almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.
sum almonds citrustot walnuts watermelon pecans apples cranberries blueberries grapes plumtot peas potatoes cherries cabbage cucumbers tomatoes tobacco pumpkins strawberries squash peaches greens onions sweet_p pistachios pears asparagus peppers cantaloupe lettuce if hq~=.

ttest spec_crop, by(insect) 
*etc
