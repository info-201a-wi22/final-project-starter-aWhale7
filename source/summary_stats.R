nyc_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv", stringsAsFactors = FALSE)
library(tidyverse)

#finding the district with the highest number of SNAP Households
district_highest <- nyc_data %>% 
  group_by(District) %>% 
  summarise(totals = sum(Total.SNAP.Households)) %>% 
  filter(totals == max(totals)) %>% 
  pull(District)

#finding the district with the lowest number of SNAP Households
district_lowest <- nyc_data %>% 
  group_by(District) %>% 
  summarise(totals = sum(Total.SNAP.Households)) %>% 
  filter(totals == min(totals)) %>% 
  pull(District)

#finding the year with the highest number of cases
year_highest <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_year = sum(Total.SNAP.Households)) %>% 
  filter(totals_year == max(totals_year)) %>% 
  pull(Year)

#the number of cases in the highest year
value_highest <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_year = sum(Total.SNAP.Households)) %>% 
  filter(totals_year == max(totals_year)) %>% 
  pull(totals_year)

#the temporary households in the highest year
temp_2013 <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_temp = sum(Temporary.Assistance.SNAP.Households)) %>% 
  filter(Year == "2013") %>% 
  pull(totals_temp)

#the proportion of temporary household in the highest year
prop_temp_2013 <- temp_2013 / value_highest
            
              