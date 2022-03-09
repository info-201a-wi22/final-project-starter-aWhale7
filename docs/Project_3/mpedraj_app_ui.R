# Matthew UI

library(dplyr)
library(plotly)
library(shiny)

ui <- navbarPage(
  "Snap Benefits Per District",
  # first page which showcases introduction
  tabPanel("Introduction", 
           titlePanel("Total Snap Benefits in each district in New York"),
                    
                    sidebarPanel(
                      # widgets for the graph, selects the county to focus on
                      selectInput(
                        inputId = "District",
                        label = "Choose District",
                        choices = unique(snap_benefits$District),
                        multiple = FALSE,
                        selected = "Albany"),
                      # widget where you can select the starting year to view the data
                      selectInput(
                        inputId = "Year",
                        label = "Choose Year",
                        choices = unique(snap_benefits$Year),
                        multiple = FALSE,
                        selected = "2002"),
                      mainPanel(
                        plotlyOutput("bar_graph"),
                        p("The purpose of including this chart was to be able to see the total SNAP (Supplemental Nutrition Assistance Program()) benefits per district each year 
                          in an interactive bar chart. The values of SNAP benefits, separated by month (which can be seen in a dash that separates values in each line in the chart), 
                          starts from the lowest SNAP benefits (in $) to the highest Total SNAP Benefits per year. Two widgets are included in the chart, where a user is able to select 
                          a specific district, as well as a certain year to start the data off at. The graph showcases how in most counties in the State of New York, the maximum amount 
                          of Total SNAP Benefits rises as each year passes. The initial years of Total Snap Benefits were relatively low, as there may be no need for any individual to utilize 
                          them off of. However, there are peaks in chart where the maximum amount of Total SNAP Benefits in one month in one year had a higher peak; this finding could be a result
                          of economic crises that befell the state of New York, with cuts to Food Stamps in 2013. Although the value of Total SNAP benefits lowered the following years,
                          the recent COVID-19 pandemic caused a sudden increase in Total SNAP Benefits in the year 2020, which had severe ramifications for every individual, being forced to stay at home 
                          and not be able to work in order to reduce the spread of the Coronavirus. Overall, this graph showcases how SNAP benefits are utilized greatly in times of need,
                          when individuals are not able to sustain themselves as a result of global or local events that negatively affect the economical positions of each person."),
                      ))))