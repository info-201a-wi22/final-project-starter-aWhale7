# Interactive Pie Chart

# Loads necessary libraries
library(dplyr)
library(plotly)
library(shiny)

# Loads CSV file into a variable for manipulation
snap_var <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv",
                      stringsAsFactors = FALSE)

# extracts all years from the data
years <- unique(snap_var$Year)

# extract all distrcits from the data 
districts <- unique(snap_var$District)


# Create input dropping for a list of years to choose from 
snap_years <- selectInput(
  inputId = "chart_years",
  label = "Please select a year.",
  choices = years,
  selected = "2002"
)

# Create input dropping for a list of years to choose from 
snap_districts <- selectInput(
  inputId = "chart_districts",
  label = "Please select a district.",
  choices = districts,
  selected = "Albany"
)


# Filters down the data set to only have the mean number of Temp and Non Temp 
# assistance SNAP households within an inputted district within an inputted year
build_piegraph <- function(data, year_choice, district_choice) {
  
  snap_selection <- data %>%
  select(1, 5, 9, 12) %>%
  group_by(Year, District) %>%
  filter(Year == year_choice) %>% # CHANGE TO YEAR INPUT
  filter(District == district_choice) %>% # CHANGE TO DISTRICT INPUT
  mutate(tempMean = mean(Temporary.Assistance.SNAP.Households)) %>%
  mutate(nonTempMean = mean(Non.Temporary.Assistance.SNAP.Households)) %>%
  select(1, 2, 5, 6)



# Pulls the Temp Mean and stores in a variable
pulled_temp <- snap_selection[1,3] %>%
  pull(tempMean) %>%
  round()

# Pulls the Non Temp Mean and stores in a variable
pulled_nontemp <- snap_selection[1,4] %>%
  pull(nonTempMean) %>%
  round()

# Creates the labels and the values for the pie chart
label <- c("Temporary Assistance SNAP Households",
           "Non Temporary Assistance SNAP Households")
value <- c(pulled_temp, pulled_nontemp)

# Creates the pie chart
snap_pie <- plot_ly(snap_selection,
                    labels = label,
                    values = value,
                    type = "pie",
                    textinfo ="label+percent"
                    )
}



# defining page
mhowes_chart <- tabPanel(
  titlePanel("Temporary Vs. Non-Temporary SNAP households per year"),
  
  sidebarLayout(
    sidebarPanel(
      snap_years,
      snap_districts
    ),
    
    mainPanel(
      plotlyOutput("mh_graph"),
    )
  )
)



ui <- navbarPage(
  "test",
  mhowes_chart
)


server <- function(input, output) {
  output$mh_graph <- renderPlotly(
    return(build_piegraph(snap_var, input$chart_years, input$chart_districts))
  )
}

shinyApp(ui, server)
