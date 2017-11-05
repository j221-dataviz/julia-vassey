Summary of the project on infant mortality rates in U.S. counties.

what has been done so far:

1. Using CDC WONDER, we generated a .txt file showing infant mortality rates from 1999 to 2015 in all counties in the U.S., we also broke down this data for Black and Latino population in separate  .txt files, as well as form the last 5 years - 2011 - 2015. 
2. Peter whote R script that grabed data from the Census Bureau API at the country level from the American Community survey (2011-2015 5-year estimates) and joined it to the infant mortality data for 2011-2015.
3. The counties.csv file was generated, which I uploaded to Tableau Public and plotted the infant mortality rate on Y axis, pc black and pc latino (in separate sheets) with household median income and household in poverty variables. I placed county and states in Details. I also created a separate sheet, where I placed infant mortality rate on Y axis, median household income on X axis and also placed infant mortality rate in Size.
4. Challenge: I tried to place the data in CARTO and got the error message that "there's no geometry in your data that could be styled. Please georeference or manually add data to visualize." Once I overcome this obstacle, I shoudl be mindful of only having data for half of the states, as CDC WONDER did not include statictically insignificant counties. That might make the map look weird. 
5. My further plan is to obtain data for more variables such as alcohol and methadone use and rates of STDs to link them to infant mortality. I sent this request to CDC communications, but have not heard from them yet.
6. I also need to think about if I should get back to my initial data and compare earlier rates in 1999-2004, 2005-2010 with the rates in 2011 to 2015 or it will make my visualization too crowded?












