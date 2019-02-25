Summary document
================

Sunflower and Honey Bee Health

### Data

1.  Outcome variable : Varroa mites and Nosema parasite loads as indicators of honey bee health.

Data source: USDA Animal and Plant Health Inspection Services (APHIS) Survey of Honey Bee Pests and Disease, containing the geographic coordinates of the apiaries.

429 apiaries in 33 states throughout the United States) and year the sample was taken (2009 to 2014).

1.  sunflower acreage in a 2-km radius of apiaries from NASS Cropscape data

2.  control variables : forage availability (NDVI?) and weather, from NASS’ Vegscape layers and Oregon State University’s Prism database.

``` r
#The USDA APHIS conducts the Honey Bee Pest and Disease Survey as a means of identifying pests,

#pathogens, and disease affecting honey bees in the United States. 

# This data set contains information
# on apiary samples collected from 2009 to 2014 throughout the United States. Forty states with 2552 
# samples are in the data set. 

# In each sampled apiary, at least 8 colonies are tested for a number of diseases and pests. 
# Not all samples are tested for pollen residue; only 676 samples have pollen sample results.

# Since there is no crop information for samples in Hawaii, we exclude these areas from our analysis as well.
```

### Methods

To estimate the degree of exposure to sunflower, we map the sampled non-migratory apiaries in APHIS onto NASS cropscape data to determine the crops grown within a two mile radius of each apiary. The resolution of these data is set at 30 meters squared per pixel (USDA NASS n.d.). We extract the crop area within two miles of each apiary as this is vicinity in which bees typically do most of their foraging (Eckert, 1933). Therefore, this two mile area, which comprises over 8,000 acres, provides the best estimate of the crops and landscape that bees would interact with during their foraging. We then calculate the percentage of the two mile buffer area occupied by sunflower with the assumption that a linear relationship exists between changes in treated crop area and morbidity loads.

``` r
# To control for unobserved regional effects, we use USDA census regions. These regions are selected to
# increase comparability with studies on overwintering losses and to isolate regional cropping patterns.
```

we start by exploring the correlation between crop layer and honey bee pests. We compare colonies located near sunflowers to those further away, during planting, blooming versus other times of year. we also plan to take into account the biology, honey bee educators, honey bee patterns.

``` r
# For our analysis, we first use a logit regression to ask what factors are associated with finding
# neonicotinoid contamination in the hive. Second, we use a multivariate regression to estimate the effect of neonicotinoid contamination on colony Nosema and Varroa loads. We use several specifications, first
# with no fixed effects, then adding fixed effects for region and year. Then we include other controls for
# forage availability and weather. In the first stage, we compare those apiaries that are near neonicotinoid-
# treated crops whose samples are taken during planting to other apiaries near neonocotinoid-treated crops
# whose samples are taken other times of year, and to apiaries who are not near treated crops. For the
# second analysis on health outcomes, using the fixed effects, we compare disease outcomes of those
# apiaries where neonicotinoids are found to apiaries tested in the same region, in the same year and during
# the same time of year.
```

### Results

Sunflower acreage map

[sunflower map](sunflower_map.png)

Plot the raster density maps for Varroa mites and Nosema parasites for non-migratory apiaries with pollen results.

[summary table](summary.png)

The first stage examines whether an apiary with a large share of sunflower within the foraging radius have a higher probability to have less insests problem during certain times of the year. In other words, we ask at which time of the year do we observe insects problem in the apiary, and does this timing align with planting or blooming of sunflower.

We aggregate the percent area of all 9 commonly neonicotinoid-treated crops and interact these numbers with planting

and bloom time. Planting time and bloom time are both dummy variables indicating whether any treated crops within the 2-mile radius are being planted or in bloom on the date of the sample collection

Crop acre*Bloom time Crop acreage Planting time Crop acre*Planting time Bloom time

Minimum Temperature NDVI Precipitatio

In the second stage, we examine whether being contaminated by neonicotinoids is associated with an increase in disease loads.

We run the same regressions with mites loads as the outcome variable and find little evidence that neonicotinoid contamination affects Varroa mite levels

Nosema Parasite / Varroa Mites Neonics NDVI Minimum Temperature Precipitation

take a paragraph to say where we have sunflowers and where we don;t

divide by state, in our sample,

seasonality, sun flower blooming, control for the timing, in 2km radius, control for the timing and control for location

#### summary statistics

how many observations have any sunflower within the 2 mi radius

To control for the timing of exposure to nearby sunflowers, we collect information on the time of planting and blooming for sunflowers. NASS collects agricultural plant timing data for select crops in some states.

We compile information on the planting percentage by month for the United States each year. Most spring planting occurs between April and June. Fall planting occurs between September and November. Due to a lack of information, we estimate the planting window for canola to be from April 20 to June 10 every year. Information on bloom timing of honeybee forage plants is provided on HoneyBeeNet, which not only lists the plants that bees frequently forage within each region within each state, but also whether each plant is significant nectar source or not (Nickeson, 2010).

when were those samples were taken

-   take the lat and lon of the sampleid that we already have in the data

extract the acreage information from the NASS Cropscape data?

##### correlation

geocode bee hives on crop model, diversity of colonies of sun flower

##### regression

summary stats on the existing, comparison within the sate (near)

it seems almost 90% of the sampleid have 0 acreage of sunflowers around them.

11%, from 900 up to 2418300, I guess the unit is km squared. sorry, that's 85 observations

summary statistics, correlation

oct sept, sampling, try for may-june lited time frames (late summer and fall)

create a simple summary table that says number of observations by month and year, and by state for obs with and w/o sunflower? (you can drop the neonic stuff too)

group 0 is no sunflower, group 1 is at least 900m^2 sunflower acreage within the 2km radius.
