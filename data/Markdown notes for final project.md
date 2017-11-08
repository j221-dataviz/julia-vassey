Summary of the project on infant mortality rates in U.S. counties.

what has been done so far:

1. Using CDC WONDER, we generated a .txt file showing infant mortality rates from 1999 to 2015 in all counties in the U.S., we also broke down this data for Black and Latino population in separate  .txt files, as well as form the last 5 years - 2011 - 2015. 
2. Peter whote R script that grabed data from the Census Bureau API at the country level from the American Community survey (2011-2015 5-year estimates) and joined it to the infant mortality data for 2011-2015.
3. The counties.csv file was generated, which I uploaded to Tableau Public and plotted the infant mortality rate on Y axis, pc black and pc latino (in separate sheets) with household median income and household in poverty variables. I placed county and states in Details. I also created a separate sheet, where I placed infant mortality rate on Y axis, median household income on X axis and also placed infant mortality rate in Size.
4. I created a map in CARTO: https://juliavv1.carto.com/builder/1349654e-7c34-421e-97ac-493be6c3da11/embed that shows infant mortality rates by states and counties. Challenge: to figure out how to better present states and counties with missing data, as CDC WONDER did not include statictically insignificant counties. Right now when I hover over counties with missing data, it just shows the names of the county and the state with no infant mortality rate. It might look confusing, becuase only I know that CDC did not have sufficient data. Otherwise I think the color coded map looks relatively decent. 
5. My further plan is to obtain data for more variables such as alcohol and methadone use and rates of STDs to link them to infant mortality. I sent this request to CDC communications, but have not heard from them yet.
6. I also need to think about if I should get back to my initial data and compare earlier rates in 1999-2004, 2005-2010 with the rates in 2011 to 2015 or it will make my visualization too crowded?












