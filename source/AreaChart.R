

# load dplyr and ggplot2 
library("dplyr")
library("ggplot2")

# load CSV file onto variable `snap_benefits`
snap_benefits <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv")

# title variable `most_benefits` and create a data frame with Year, Month, and total snap benefits
most_benefits <- snap_benefits %>%
  # pipe operator to access the `snap_benefits` variable created on top
  group_by(Year, Month) %>%
  filter(Year >= 2015 & Year <= 2021) %>%
  # groups by year and month
  filter(Total.SNAP.Benefits == max(Total.SNAP.Benefits)) %>%
  # filter to only get the highest amount of total snap benefits in each month in each year
  select(Year, Month, Total.SNAP.Benefits, District)
  # selects the Year, Month, and Total Snap Benefit to be included in the data frame

# pipe operator to access most_benefits data frame
most_benefits %>%
  # area chart
  ggplot(aes(x = Year, y = Total.SNAP.Benefits, fill = Month))+
         geom_area(alpha = 10, size = 1.0, color = "black")+
         ggtitle("Snap Benefits in New York City, New York")+
         labs(y = "Total Snap Benefits (in $)", x = "Year (2015-2021)")
  # x-axis is the Year, y is the highest Total Snap Benefits in each month and each year, fill is the month

  