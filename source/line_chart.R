nyc_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv", stringsAsFactors = FALSE)
library(tidyverse)
library(ggplot2)

total_per_year <- nyc_data %>% 
  group_by(Year) %>% 
  summarize(sum(Total.SNAP.Households)) 

names(total_per_year) [2] <- "households"

line_chart <- ggplot(data = total_per_year, aes(x = Year, y = households, group = 1)) +
  geom_line(
    color = "purple"
  )+
  geom_point()+
  labs(
    title = "Total SNAP Households Per Year",
    y = "Number of households",
    x = "Year"
  )