# load required libraries
library(dplyr)
library(readr)

im2011_15 <- read_csv("data/counties2011_2015.csv") %>%
  mutate(period = "2010-15", 
         GEOID = as.character(GEOID))
im2006_10 <- read_csv("data/counties2006_2010.csv") %>%
  mutate(period = "2006-10", 
         GEOID = as.character(GEOID))


counties <- bind_rows(im2011_15,im2006_10)

write_csv(counties, "counties2006_2015.csv", na="")
