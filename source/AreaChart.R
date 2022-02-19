

# load dplyr and ggplot2 
library("dplyr")
library("ggplot2")

# load CSV file onto variable `snap_benefits`
snap_benefits <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv")

# title variable `New_York_benefits` and create a data frame with Year, Month, and total snap benefits
New_York_benefits <- snap_benefits %>%
  # pipe operator to access the `snap_benefits` variable created 
  group_by(Year, Month, District) %>%
  # groups the data frame by Year, Month, and District
  filter(District == "New York City")%>%
  # filters the district variable to only show New York City, the district that will be focused on
  filter(Year >= 2015 & Year <= 2021) %>%
  # filters the Year variable to only include 2015 to 2021
  select(Year, Month, Total.SNAP.Benefits, District)
  # selects the Year, Month, and Total Snap Benefit to be included in the `most_benefits` data frame

area_chart <- New_York_benefits %>%
  # area chart
  ggplot(aes(x = Year, y = Total.SNAP.Benefits, fill = Month))+
  # x-axis is the Year, y is the highest Total Snap Benefits in each month and each year, with color filled month
         geom_area(alpha = 10, size = 1.0, color = "black")+
         ggtitle("Snap Benefits in New York City, New York")+
  # title for the Area Chart
         labs(y = "Total Snap Benefits (in $)", x = "Year (2015-2021)")
  # labels for x and y axis

  