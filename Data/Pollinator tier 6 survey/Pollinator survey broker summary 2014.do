 n_placed14
 total n_placed14
 
 sum avg_price low_price high_price
 mean avg_price low_price high_price [fweight = n_placed14]
 
 sum grade_premiumd
 
 sum grade
 mean grade [fweight = n_placed14]
 sum not_graded if not_graded==0
 
 sum avg_col_acre high_col_acre low_col_acre
mean avg_col_acre [fweight = n_placed14]

total difficulty
total n_keepers


total n_short
 total n_more
 
 
 sum add100d
 
 total n_growers
sum n_keepers n_growers


graph twoway scatter n_short winter_loss
