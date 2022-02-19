# R script for the creation of a bar plot showcasing which months have had
# the most amount of SNAP benefits allocated to them.

# Loading needed packages for coding
library("ggplot2")
library("dplyr")

# Load the SNAP data from the github repo
snap_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv", stringsAsFactors = FALSE)

# Begin to perform filtering operations on data set to isolate needed data.
# By year, count which months have had the highest amount of SNAP benefits 
# allocated to them

# This needs to return a data frame of one column with each month and another 
# column displaying the amount of times that month received the highest SNAP benefits  
# within a particular year. 

count_highest_benefit_months <- snap_data %>%
  group_by(Year) %>%
  filter(Total.SNAP.Benefits == max(Total.SNAP.Benefits)) %>%
  select(Year, Month.Code)

# Mutating a column into the sorted table in order to label the months better than by Month.Code
count_highest_benefit_months <- count_highest_benefit_months %>% 
  mutate(Month = if_else(Month.Code == 1, "Jan", 
                         if_else(Month.Code == 2, "Feb",
                                 if_else(Month.Code == 3, "Mar",
                                         if_else(Month.Code == 4, "Apr", 
                                                if_else(Month.Code == 5, 'May',
                                                        if_else(Month.Code == 6, "Jun",
                                                                if_else(Month.Code == 7, "Jul",
                                                                        if_else(Month.Code == 8, "Aug",
                                                                                if_else(Month.Code == 9, "Sep",
                                                                                        if_else(Month.Code == 10, 'Oct',
                                                                                                if_else(Month.Code == 11, 'Nov',
                                                                                                        if_else(Month.Code == 12, "Dec", "")))))))))))))

# Creating the dataframe for the plot creation 
# (I know there has to be a better way to count the amount of times a Month had the highest total SNAP benefits, I just do not know it)
plot_data <- data.frame(
  months = c("Jan", "Feb", "Mar", "Apr"," May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
  count = c(sum(count_highest_benefit_months$Month == "Jan"),
            sum(count_highest_benefit_months$Month == "Feb"),
            sum(count_highest_benefit_months$Month == "Mar"),
            sum(count_highest_benefit_months$Month == "Apr"),
            sum(count_highest_benefit_months$Month == "May"),
            sum(count_highest_benefit_months$Month == "Jun"),
            sum(count_highest_benefit_months$Month == "Jul"),
            sum(count_highest_benefit_months$Month == "Aug"),
            sum(count_highest_benefit_months$Month == "Sep"),
            sum(count_highest_benefit_months$Month == "Oct"),
            sum(count_highest_benefit_months$Month == "Nov"),
            sum(count_highest_benefit_months$Month == "Dec")
            )
)

# beginning of the creation of the plot with ggplot
bar_plot <- ggplot(data = plot_data) +
  geom_col(mapping = aes(x = months, y = count)) +
  
  # Scaling the x axis specifically to be in order of a year
  scale_x_discrete(limits = c("Jan", "Feb", "Mar", "Apr"," May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
  
  # Adding a title and better axis labels
  labs(
    title = "Months given the highest amount of SNAP Assistance", # plot title
    x = "Months", # x-axis label
    y = "Number of times a month was given the 
    most assistance within a year" # y-axis label
  ) +
  
  # line here is to center the title of the chart. This was taken from stack overflow. 
  theme(plot.title = element_text(hjust = 0.5))



# Paragraph write up for why it's important. 
# This chart showcases the amount of times a certain month within a year was allocated
# the most amount of SNAP assistance. Since our data set has the years range from 2002 to 2021, 
# there are 20 years to choose the highest month. A column chart was used since we wanted an 
# easy way to compare which months had the highest count. The column chart therefore totals up to a 20 y-axis
# count. This column chart is important as it can allow policy makers to see broad timings of
# when the SNAP program used the most amount of resources. This overview can allow them to better
# understand which timings for the program need the most amount of resources. This chart can also 
# provide some insight as to why a certain time needs the most amount of SNAP assistance. For example,
# the winter months of Nov-Jan seem to be the months which generally use the greatest amount of SNAP
# assistance. This may be attributed to the increase of family mouths to feed in family gatherings for
# the holiday season. 
