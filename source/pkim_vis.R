# Loading needed packages
library(dplyr)
library(plotly)
library(shiny)

# Will create the Shiny app via the one .R file method

# Load data
snap_data_pk <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv",
                      stringsAsFactors = FALSE)

# Clean data to be useful in the chart to create 
vis_data <- snap_data_pk %>%
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
      plotlyOutput("line_plot"),
      p("This chart aims to understand how the amount of SNAP benefits per individual has changed over time wihtin NY. This was calculated by adding the total
        amount of non-temporary SNAP benefits given and the total amount of non-temporary SNAP individuals per year, and then dividing these two totals
        to find the amount of SNAP benefits given to each person per year. This chart has been divided into 3 different time slots, with the 4th time
        showcasing all the years in the dataset. These slots were chosen to represent a specific set of time to see how the amount of benefits
        per person had changed. For example, the 2002-2009 slot was specifically chosen to see the change in SNAP benefits during the recession 
        of 2008.")
    )
  )
)


# I believe you'll only need code from above this part.

#Summary portion
# The visualization which showcased the change of SNAP benefits given per person can help us see how the NY SNAP program has fared over time. An 
# important assumption in measuring this statistic is that as a smaller amount of SNAP benefits given per person, the less the receiving individuals
# actually need to rely on the SNAP program, and vice versa. Therefore, it is also assumed that the SNAP program will be beneficial for recipients when 
# more amounts are given in times of need or crisis, and less is given out in times characterized by good economic trends.

# Given these assumptions, the SNAP program seems to have worked well in its purpose. SNAP benefits have been seen to rise in harder times and fall
# in times identified by good economic standings. The amount given per person jumped up in 2009, which can be better understood in the context of the 
# 2008 financial recession. With many losing their jobs in this time, it makes sense that more SNAP benefits are given per person. The amount slowly 
# decreased in the period of 2010 - 2015, which can be best described as a time where the US economy recovered well from the recession. The SNAP amount
# however did jump up in the 2020 time frame, as the introduction of COVID-19 caused many disruptions to everyday life all across America. Overall, 
# the SNAP program can be shown to follow the trends of big-time events which reflect the overall economic health of the US.


# Load ui
ui <- navbarPage(
  "Visualization for final (change name)",
  pkim_chart
)


# Load server
server <- function(input, output) {
  output$line_plot <- renderPlotly(
    return(build_linechart(vis_data, input$range_select))
  )
}


# Create shinyApp
shinyApp(ui, server)