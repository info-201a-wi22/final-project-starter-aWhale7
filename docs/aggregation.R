# Aggregation (#3)

library(readr)
library(dplyr)

snap_data <- read_csv("data/SNAP_data.csv")

max(snap_data$Year)

tash_data <- snap_data %>%
             select(5,9) %>%
             group_by(District) %>%
             summarize_at((1), funs(mean(.)))

ntash_data <- snap_data %>%
              select(5,12) %>%
              group_by(District) %>%
              summarize_at((1), funs(mean(.)))

district_data <- cbind(tash_data, ntash_data[,2])

district_data <- district_data %>%
                 rename(
                   District = District,
                   `Temporary Assistance SNAP Households Average` = `Temporary Assistance SNAP Households`,
                   `Non-Temporary Assistance SNAP Households Average` = `Non-Temporary Assistance SNAP Households`)

district_data[,2] <- round(district_data[,2])
district_data[,3] <- round(district_data[,3])

View(district_data)