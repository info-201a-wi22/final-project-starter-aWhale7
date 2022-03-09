library(dplyr)
library(plotly)
library(shiny)

# Will create the Shiny app via the one .R file method

# Load data
snap_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv",
                      stringsAsFactors = FALSE)

# Clean data to be useful in the chart to create 
vis_data <- snap_data %>%
  group_by(Year) %>%
  summarise(
    total_nontemp_persons = sum(Non.Temporary.Assistance.SNAP.Persons, na.rm = TRUE),
    total_nontemp_benefits = sum(Non.Temporary.Assistance.SNAP.Benefits, na.rm = TRUE)
  ) %>%
  select(Year, total_nontemp_persons, total_nontemp_benefits) %>%
  mutate(total_benefit_per_person = total_nontemp_benefits / total_nontemp_persons) %>%
  arrange(Year)

# doing a test on the visualization data (Ignore this part)
# test <- vis_data %>%
#   filter(Year == "c(2002:2007)")
# 
# test2 <- vis_data[, vis_data$Year == c(2002:2009)]
# 
# names <- colnames(test)
# 
# testplot <- plot_ly(
#   data = test,
#   x = ~Year,
#   y = ~total_benefit_per_person,
#   type = "scatter",
#   mode = "lines"
# )

# Create an input dropdown for the user to choose between 4 different ranges of years 
year_input <- selectInput(
  inputId = "range_select",
  label = "Please select a range of years",
  choices = list(
    "2002 - 2009" = "chunk_1",
    "2009 - 2016" = "chunk_2",
    "2016 - 2021" = "chunk_3",
    "2002 - 2021" = "all_years"
  )
)


# Defining function to use in creating the plot
build_linechart <- function(data, range_choice = "") {
  
  # Breaking up the data set into year chunks to display 
  # Filter data to only show inputted values
  if (range_choice == "chunk_1") {
    plot_data = data %>%
      filter(Year <= 2009)
    
  } else if (range_choice == "chunk_2") {
    plot_data = data %>%
      filter(Year >= 2009 & Year <= 2016 )
    
  } else if (range_choice == "chunk_3") {
    plot_data = data %>%
      filter(Year >= 2016 & Year <= 2021)
    
  } else {
    plot_data = data %>%
      filter(Year == c(2002:2021)) 
  }
  
  # Build Linechart
  line_plot <- plot_ly(
    data = plot_data,
    x = ~Year,
    y = ~total_benefit_per_person,
    type = 'scatter',
    mode = "lines") %>%
    
    layout(title = 'Trend of non-temporary SNAP 
benefits per person in NY over time',
           xaxis = list(title = 'Year'),
           yaxis = list(title = 'Amount of SNAP dollars per 
non-temporary resident')
    )
  
}

# defining page for the visualization
pkim_chart <- tabPanel(
  "Trend of Benefits Given",
  titlePanel("How has the amount of SNAP benefits per person changed over time?"),
  
  sidebarLayout(
    sidebarPanel(
      year_input
    ),
    mainPanel(
      plotlyOutput("line_plot")
    )
  )
)


