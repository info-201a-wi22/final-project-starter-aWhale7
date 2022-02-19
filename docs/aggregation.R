# Aggregation (#3)

# Added the necessary libraries to the script
library(readr)
library(dplyr)

# Reads the csv file into the snap_data variable for later manipulation
snap_data <- read_csv("data/SNAP_data.csv")

# Creates a data frame that only contains the average Temporary Assistance
# SNAP Households inside of it, paired with their corresponding districts
tash_data <- snap_data %>%
             select(5,9) %>%
             group_by(District) %>%
             summarize_at((1), funs(mean(.)))

# Creates a data frame that only contains the average Non-Temporary Assistance
# SNAP Households inside of it, paired with their corresponding districts
ntash_data <- snap_data %>%
              select(5,12) %>%
              group_by(District) %>%
              summarize_at((1), funs(mean(.)))

# Combines the previous two data frames into a single data frame
district_data <- cbind(tash_data, ntash_data[,2])

# Renames the columns of the newly combined data frame so that they make more
# sense in regard to the purpose of the data frame
district_data <- district_data %>%
                 rename(
                   District = District,
                   `Temporary Assistance SNAP Households Average` = `Temporary Assistance SNAP Households`,
                   `Non-Temporary Assistance SNAP Households Average` = `Non-Temporary Assistance SNAP Households`)

# Rounds the averages to the nearest whole number for the purpose of readability
district_data[,2] <- round(district_data[,2])
district_data[,3] <- round(district_data[,3])

View(district_data)