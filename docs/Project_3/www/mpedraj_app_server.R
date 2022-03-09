
# Matthew Kyle Pedraja: Interactive Area Chart
library(dplyr)
library(plotly)
library(shiny)


server <- (function(input, output){
# stores csv_file in a variable
snap_benefits <- read.csv('https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv',
                      stringsAsFactors = FALSE)

# creates data frame that pertains to year, district, as well as snap benefits 
total_benefits_snap_data <- snap_benefits %>%
    select(Year, Month, District, Total.SNAP.Benefits)


# bar graph data for Shiny
output$bar_graph <- renderPlotly({
  
  snap_benefits_district <- total_benefits_snap_data %>%
    filter(District == input$District)%>%
    # filters District where a user can choose a specific district to focus on
    filter(Year >= input$Year)%>%
    # filters Year where user is able to choose a specific starting year to view the data
    summarize(Total.SNAP.Benefits, Year, District)%>%
    ggplot(aes(x = Year, y = Total.SNAP.Benefits)) +
    geom_bar(stat = "Identity") +
    labs(title = "Total Snap Benefits per month by Year in each County", x = "Year", y = "Total Snap Benefits (in $)") +
    xlim(2002, 2021)
})})

