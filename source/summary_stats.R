nyc_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv", stringsAsFactors = FALSE)
library(tidyverse)

district_highest <- nyc_data %>% 
  group_by(District) %>% 
  summarise(totals = sum(Total.SNAP.Households)) %>% 
  filter(totals == max(totals)) %>% 
  pull(District)

district_lowest <- nyc_data %>% 
  group_by(District) %>% 
  summarise(totals = sum(Total.SNAP.Households)) %>% 
  filter(totals == min(totals)) %>% 
  pull(District)

year_highest <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_year = sum(Total.SNAP.Households)) %>% 
  filter(totals_year == max(totals_year)) %>% 
  pull(Year)

temp_2013 <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_temp = sum(Temporary.Assistance.SNAP.Households) %>% 
  filter(Year == "2013") %>% 
  pull(totals_temp)

  
prop_temp_2013 <- nyc_data %>% 
  group_by(Year) %>% 
  summarise(totals_year = sum(Total.SNAP.Households)) %>% 
  filter(totals_year == max(totals_year)) %>% 
  
            
              