library(dplyr)
library(shiny)
library(shinyWidgets)
library(plotly)
snap_data <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv",
                      stringsAsFactors = FALSE)
snap_benefits <- read.csv('https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-aWhale7/main/data/SNAP_data.csv',
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
      plotlyOutput("line_plot"),
    )
  )
)
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


#shinyUI
shinyUI(fluidPage( theme = "bootstrap.css",
                   setBackgroundColor(
                     color = c("#EBDEF0 ")
                   ),
  tabsetPanel(
 page_one <- tabPanel(
    "Introduction",
    titlePanel("Analyzing Government Food Support in New York"),
        mainPanel(
          h1("What Our Project Is About"),
         p("Our group’s project focuses on the change in number of persons who 
         utilize SNAP within the different districts of the State of New York 
         over the past 5 years to confirm whether or not the necessary parties 
         are receiving the help that they need. We all believe that no one 
         should have to worry about whether or not there will be food on the
         table each night, so SNAP, the Supplemental Nutrition Assistance 
         Program, is something that each of us is passionate about for its 
         success and ease of access. With this project, we hope to gain a better
         understanding of its impact on people’s lives as well as to see whether
         or not the U.S. government is holding up their end on allowing residents
         of a selected State, being New York in this case, to have affordable 
         food to feed their families. Finally, we aim for this information to
         be more publicized to potentially make a difference if need be.
"),
         h2("Key Questions Being Addressed"),
         p("
1. Which month(s) historically have the most Total SNAP benefits allocated to them?", br(),"
2. How does the number of SNAP receiving persons change throughout time? 
This can be categorized by NY as a whole or by individual districts as well.", br(),"
3. How did COVID-19 affect the number of SNAP benefits being distributed?", br(),"
4. Does the number of households in a district correlate with the number of SNAP benefits being allocated in said district?
"),
         img(src = "https://foodtank.com/wp-content/uploads/2019/01/food-tank-income-food-insecurity.jpg",
             height ="60%", width = "60%")
        )
    ),
  
 page_two <- tabPanel(
   "Interactive Line Chart",
   titlePanel("Interactive Line Chart"),
   
   mainPanel(
     pkim_chart,
     p("This chart aims to understand how the amount of SNAP benefits per individual has changed over time wihtin NY. This was calculated by adding the total
        amount of non-temporary SNAP benefits given and the total amount of non-temporary SNAP individuals per year, and then dividing these two totals
        to find the amount of SNAP benefits given to each person per year. This chart has been divided into 3 different time slots, with the 4th time
        showcasing all the years in the dataset. These slots were chosen to represent a specific set of time to see how the amount of benefits
        per person had changed. For example, the 2002-2009 slot was specifically chosen to see the change in SNAP benefits during the recession 
        of 2008.")
   )
   ),
   
   page_three <- tabPanel(
     "Interactive Pie Chart",
     titlePanel("Interactive Pie Chart"),
     mainPanel(
       mhowes_chart,
       p("This pie chart aims to view the comparison between the amount of permanent and temporary SNAP
         receiving households. The pie graph will automatically update according to the year and distrcit
         chosen to showcase the comparisons between permanent (non-temporary) and temporary SNAP receiving
         households. We chose to filter these by Year and District to see how the comparisons between these
         two variables differed by specific districts and Years.")
     )
   ),
 
   page_four <- tabPanel(
     "Interactive Bar Graph",
     titlePanel("Interactive Bar Graph"),
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
     ),
       mainPanel(
         plotlyOutput("bar_graph"),
         p("This bar graph aims to showcase the total SNAP benefits handed out to counties by Year.
           The graph first showcases all years of our dataset, and the user can choose specific years
           to showcase by using the dropdown. The all years after the chosen year will then be selected.
           This design choice was made to allow the user to easily get a range of years to view the 
           total amount of SNAP benefits per district if they wish.")
   )
   ),
   
   page_five <- tabPanel(
     "Key Takeaways",
     titlePanel("Key Takeaways"),
 h4("
1. The amount of non temporary SNAP benefits began to rise until 2010, where the benefits slowly started to to decline. This decline continued until 2019; the number of benefits shot up drastically.
", br(),"2. In the majority of New York’s counties, the ratio of temporary to non-temporary households remains quite unchanged throughout the years. There aren’t any crazy changes that take place.
", br(),"3. A really interesting discovery is that the isolated benefits for each county has a really similar shape to the shapes of the rest of the county. The trend across all the counties is the same trend. It begins to shift up at first, and then, shift down. Eventually, there’s a large upward shift.
"),
   ),
   page_six <- tabPanel(
     "Report",
     titlePanel("Analyzing Government Food Support in New York"),
     h4("Authors"),
     p("Paul Kim: pkim3@uw.edu", br(),"Mason Howes: mhowes@uw.edu",br(),
       "Viru Repalle: virurep@uw.edu", br(), "Matthew Pedraja: mpedraj@uw.edu"),
     h4("Affiliation"),
     p("INFO-201: Technical Foundations of Informatics - The Information School - University of Washington
"),
     h4("Date"),
     p("March 9th, 2022"),
     h4("Abstract"),
     p("We are concerned with changes to SNAP assistance given to individuals and families in need. This is a topic of concern because analyzing how the SNAP program has changed based on various relevant factors can help policy makers make more informed decisions on an important part of United States welfare to low-income parties. We plan to do this by analyzing a data set which has the amount of SNAP assistance given to families over time within the State of New York."),
     h4("Introduction"),
     p("Our group’s project focuses on the change in number of persons who utilize SNAP within the different districts of the State of New York over the past 5 years to confirm whether or not the necessary parties are receiving the help that they need. We all believe that no one should have to worry about whether or not there will be food on the table each night, so SNAP, the Supplemental Nutrition Assistance Program, is something that each of us is passionate about for its success and ease of access. With this project, we hope to gain a better understanding of its impact on people’s lives as well as to see whether or not the U.S. government is holding up their end on allowing residents of a selected State, being New York in this case, to have affordable food to feed their families. Finally, we aim for this information to be more publicized to potentially make a difference if need be.
"),
     h4("Design Situation"),
     p("Framing the Topic of Concern: Our choice of topic for this project focuses on food security and the support that is provided within the districts of New York by the U.S government, from November 2015 to June 2020. Each district contains the amount of households from each specific month, as well as provides statistics on the amount of support that was given within that district, through the SNAP (Supplemental Nutrition Assistance Program). The key issues to our topic surround economical and financial problems, with the Covid-19 pandemic affecting everyone globally, as well as issues of job security affecting income making food harder to access.
", br(), "Human Values: Values associated and connected with our topic is maintaining the well-being of our community and the right to having access to food, making sure no one is deprived of that necessity, and raising awareness on the issues of hunger. These values originate from social and economical issues that have arised especially in the 21st century regarding the financial crises and Covid-19 pandemic, with over 10.5% of households having experienced food insecurity in the United States alone in 2019", a("(Silva, 2020)", href = "https://www.npr.org/2020/09/27/912486921/food-insecurity-in-the-u-s-by-the-numbers"),"The issue of healthy foods in itself being expensive for an individual to sustain conflicts with the idea of providing food for everyone, which results in food insecurity", a(" (Food and Agriculture Organization of the United Nations, 2021).", href = "https://www.fao.org/state-of-food-security-nutrition" ),"
", br(), "Stakeholders: The direct stakeholders of our topic involves not only the citizens and residents of New York, but also other residents in different states that are experiencing food insecurity and are in need of SNAP benefits and other community based organizations, such as food banks and retail shops that provide food items for those who need it. The motivations and values the stakeholders contain is dealing and solving issues of hunger for everyone, and maintaining the well-being of the communities. Indirect stakeholders include politicians who cater to the people they are serving in order to maintain their status within the government through elections and provide assistance for struggling individuals.
", br(), "Benefits and Harms: The potential benefits by exploring our topic involve raising support in favor of making sure everyone is able to have food, greatly benefiting every individual in need of food as well as every citizen by reducing the stress of food insecurity", a("(Keith-Jennings, 2019).", href = "https://www.cbpp.org/blog/raising-snap-benefits-would-have-powerful-effects-on-food-security-poverty-health"), "However, potential harms could involve using the data provided as a means to push a political agenda and attack the political party associated, leading to a huge divide amongst the populace discouraging cooperation against solving hunger issues."
),
    h4("Research Questions"),
p("
1. Which month(s) historically have the most Total SNAP benefits allocated to them?", br(),"
2. How does the number of SNAP receiving persons change throughout time? 
This can be categorized by NY as a whole or by individual districts as well.", br(),"
3. How did COVID-19 affect the number of SNAP benefits being distributed?", br(),"
4. Does the number of households in a district correlate with the number of SNAP benefits being allocated in said district?
"),
h4("Dataset"),
p("Size: The dataset we chose has 14 columns and 13.9 thousand rows. Overall, it is a larger dataset because it has a lot of columns that are applied to thousands of rows.
", br(), "Complexity: This is a complex dataset because it contains several features that apply to a significant amount of observations. The features go in depth in several different ways. One way is that the information is sorted by districts; this sorting offers a deeper perspective that is location based. Additionally, the data goes into higher detail by specifying if the SNAP data is temporary or non-temporary. If the data is temporary then it invokes the possibility of change in the future: a sign of growth and positive change. The aforementioned data is continued to be divided into three subsections each. They have data related to households, individual persons, and the total benefits. Households give a larger summary while the person data is more scrutinous and focuses on the individual. The benefits present a conglomeration of the prior sets and shows the impact of the food assistance program. Overall, the dataset is split up by months of the year. This organization provides for a structured way to view the data. It can be analyzed to see the difference made each month.
", br(), "Origins: This dataset comes from the U.S. Government and it represents the number of people in the state of New York who are under the food assistance program. The observations are the number of people per month and distract who are in the specified columns provided. The data was collected by New York State Office of Temporary and Disability Assistance to asses the amount of food rationing that was being spent by the government. This data benefits the government because they are the ones who are spending the money on the food assistance. Therefore it would be useful to use this data to tack their spendings. By tracking their spending they are able to asses if they need to allocate more or less money in coming years, enabling them the view and predict patterns. If correctly used they can find ways to save their money. The data is validated by New York City and Upstate Welfare Management Systems and it is published by the U.S. Government so it is reasonable to say this data is trustworthy. We obtained this data from the New York government data website.
"),
h4("Findings"),
p("The number of SNAP receiving persons constantly increases over time. This increase is the result of growing population in New York. New York is a huge global hub and a center for immigration. Many immigrants start their life in this state, and they have lots of money and resources so the population is going to increase. The result of an increasing population is the increasing number of people who require food assistance. Therefore the number of SNAP persons will increased. It is obvious that the COVID 19 pandemic had a large effect on the SNAP distributions. One of the trends pointed out in the Key Takeaways is the drastic spike after 2019 going into 2020. This spike is probably due to the pandemic as it took place in 2020. The Coronavirus pandemic left several people without a job, so they couldn’t afford necessities such as food. SNAP had to step in and provide food for the people who had just lost their jobs and couldn’t afford food, causing the big change in SNAP benefits. The districts with the higher populations get more SNAP benefits. This phenomeno is probably because the more expansive populations also have more people who are struggling with food insecurity. For example, New York City has a massive population, it makes sense that they are receiving the most SNAP assistance. Meanwhile, more rural districts with a significantly lesser population receive smaller assistance. Interestingly enough however, the proportion of temporary to non-temporary households in each district is about the same for the bigger and smaller districts.
"),

h4("Discussion"),
p("Interactive Line Chart", br(), "The visualization which showcased the change of SNAP benefits given per person can help us see how the NY SNAP program has fared over time. An important assumption in measuring this statistic is that as a smaller amount of SNAP benefits given per person, the less the receiving individuals actually need to rely on the SNAP program, and vice versa. Therefore, it is also assumed that the SNAP program will be beneficial for recipients when more amounts are given in times of need or crisis, and less is given out in times characterized by good economic trends.
Given these assumptions, the SNAP program seems to have worked well in its purpose. SNAP benefits have been seen to rise in harder times and fall in times identified by good economic standings. The amount given per person jumped up in 2009, which can be better understood in the context of the 2008 financial recession. With many losing their jobs in this time, it makes sense that more SNAP benefits are given per person. The amount slowly decreased in the period of 2010 - 2015, which can be best described as a time where the US economy recovered well from the recession. The SNAP amount however did jump up in the 2020 time frame, as the introduction of COVID-19 caused many disruptions to everyday life all across America. Overall, the SNAP program can be shown to follow the trends of big-time events which reflect the high-level view of the economic health of the US.
", br(), "Interactive Bar Chart", br(),"The purpose of including this chart was to be able to see the total SNAP (Supplemental Nutrition Assistance Program) benefits per district each year 
 in an interactive bar chart. The values of SNAP benefits, separated by month (which can be seen in a dash that separates values in each line in the chart), 
 starts from the first month of SNAP benefits (in $) to the last month of Total SNAP Benefits in the year. Two widgets are included in the chart, where a user is able to select a specific district, as well as a certain year to start the data off at. The graph showcases how in most counties in the State of New York, the maximum amount of Total SNAP Benefits rises as each year passes. The initial years of Total Snap Benefits were relatively low, as there may be no need for any individual to utilize them for most purposes. However, there are peaks in the chart where the maximum amount of Total SNAP Benefits in one year had a higher peak; this finding could be a result of economic crises that befell the state of New York, with cuts to Food Stamps in 2013. Although the value of Total SNAP benefits lowered the following years the recent COVID-19 pandemic caused a sudden increase in Total SNAP Benefits in the year 2020, which had severe ramifications for every individual, being forced to stay at home and not be able to work in order to reduce the spread of the Coronavirus. Overall, this graph showcases how SNAP benefits are utilized greatly in times of need, when individuals are not able to sustain themselves as a result of global or local events that negatively affect the economical positions of each person.", br(),"Interactive Pie Chart", br(),
                          " Utilizing the interactive Pie Chart, we are easily able to visualize the number and percentage of Temporary Assistance SNAP Households in comparison to the number and percentage of Non-Temporary Assistance SNAP Households. Through testing out different years and districts, a trend becomes apparent in that a majority of the time, there is a larger percentage of Non-Temporary Assistance SNAP Households, which highlights the importance of having a stable SNAP program that provides good assistance to those who are using it. However it is not always the case where there are more Non-Temporary Households than Temporary Households, as is apparent between the years of 2002 and 2005 within the district of Albany, where Temporary Households were more prevalent.

"),
h4("Conclusion"),
p("As the years go by and the number of families that occupy New York’s districts continue to grow, having a reliable way to put food on the table becomes more and more important. Through recessions and pandemics, trends that can be witnessed through the previously provided visualizations showcase that SNAP, the Supplemental Nutrition Assistance Program, has managed to assist families and individuals in need with their nutritional help. Moving forward, it can be concluded that the SNAP program is a worthwhile resource for those who aren’t monetarily stable, and need a way to keep everyone fed and healthy.
")

)
)
)
)
