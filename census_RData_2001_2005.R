# load required packages
library(tidycensus)
library(rgdal)
library(readr)
library(dplyr)
library(tidyr)
library(tigris)
library(utils)

# set census api key. Obtain from http://api.census.gov/data/key_signup.html
census_api_key("73d546eccffc93e60660844710579fa8c64f8ea0", install = TRUE)
readRenviron("~/.Renviron")

# create list of US states, by two-letter abbrevations, plus DC and PR
states <- c(state.abb, "DC", "PR")
            
# get list of variables in the 2015 American Community Survey, 5-year estimates (i.e. 2006-2010)
acs15 <- load_variables(2005, "acs5", cache = TRUE)

#############
# get ACS 2015 5-year data, by counties

# population
population <- get_acs(geography = "county", 
                      variables = "B01003_001",
                      state = states,
                      year = 2005) %>%
  rename(population = estimate)  %>%
  select(1,2,4)

# median household income
median_household_income <- get_acs(geography = "county", 
                  variables = c("B19013_001"),
                  state = states,
                  year = 2005) %>%
  rename(median_household_income = estimate) %>%
  select(1,2,4)

# number of households
households <- get_acs(geography = "county", 
                      variables = c("B17017_001"), 
                      state = states,
                      year = 2005) %>%
  rename(households = estimate) %>%
  select(1,2,4)

# number of households in poverty
households_in_poverty <- get_acs(geography = "county", 
                   variables = c("B17017_002"), 
                   state = states,
                   year = 2005) %>%
  rename(households_in_poverty = estimate) %>%
  select(1,2,4)

# # black population (black alone, not latino). Alternative to the version below
# black_population <- get_acs(geography = "county",
#                  variables = c("B03002_004"),
#                  state = states,
#                  year = 2015) %>%
#   rename(black_population = estimate) %>%
#   select(1,2,4)

# black population (black alone or in combination, includes latino)
black_population <- get_acs(geography = "county",
                            variables = c("B02009_001"),
                            state = states,
                            year = 2005) %>%
  rename(black_population = estimate) %>%
  select(1,2,4)

# latino population (any race)
latino_population <- get_acs(geography = "county", 
                  variables = c("B03002_012"), 
                  state = states,
                  year = 2005) %>%
  rename(latino_population = estimate) %>%
  select(1,2,4)

# this isn't working - not sure why
# no health insurance
# no_health_insurance <- get_acs(geography = "county",
#                              variables = c("B992701_003"),
#                              state = states,
#                              year = 2015) %>%
#   rename(no_health_insurance = estimate) %>%
#   select(1,2,4)
# 
# # population base for health insurance
# pop_health_insurance <- get_acs(geography = "state",
#                                variables = c("B992701_001"),
#                                state = states,
#                                year = 2015) %>%
#   rename(pop_health_insurance = estimate) %>%
#   select(1,2,4)

# join data frames into one, calculate percentages where necessary
counties <- inner_join(population,median_household_income) %>%
  inner_join(households) %>%
  inner_join(households_in_poverty) %>%
  inner_join(black_population) %>%
  inner_join(latino_population) %>%
  mutate(pc_black_population = round(black_population/population*100,2),
         pc_latino_population = round(latino_population/population*100,2),
         pc_households_in_poverty = round(households_in_poverty/households*100,2),
         name=NAME) %>%
  separate(name, into = c("county", "state"), sep = ",")

# load and clean infant mortality data for 2006-2010
infant_mortality <- read_tsv("data/CDC_County_2001_2005.txt") %>%
  
  slice(1:1722) %>%
  select(3,6)
names(infant_mortality) <- c("GEOID","infant_mortality_rate")

# join to counties data
counties <- left_join(counties,infant_mortality)

# Some cleaning: remove NaNs from data, replace with zero
is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan))
counties[is.nan(counties)] <- 0

# replace "Unreliable" with NA
counties$infant_mortality_rate <- gsub("Unreliable",NA,counties$infant_mortality_rate )

counties <- counties %>%
  mutate(infant_mortality_rate=as.numeric(infant_mortality_rate))

# save as CSV
write_csv(counties,"data/counties2006_2010.csv", na="")

# works with TIGRIS package to obtain Census Bureau shapefiles
options(tigris_use_cache = TRUE)

# load Census Bureau TIGER/LINE county shapefiles
counties_map <- rbind_tigris(
  lapply(
    states, function(x) {
      counties(state = x, cb = TRUE)
    }
  )
)
plot(counties_map)

# join shapefile to Census data (fix row names first)
row.names(counties_map@data) <- c(1:3220)
counties_map@data <- inner_join(counties_map@data, counties, by="GEOID") 

# save shapefile
writeOGR(counties_map,"counties_map",layer="counties_map", driver = "ESRI Shapefile")







