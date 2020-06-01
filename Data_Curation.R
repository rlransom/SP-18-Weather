###############################################################
##Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweetpotatoes?

###############################################################

#Load necessary packages
#install.packages("tidyverse")
load(dplyr)


#Clear Environment
remove(list = ls())


#Load Raw Data from Clinton Research Station Site
Clinton <- read_csv("RAW_Clinton.csv")

#Inspect Data
##Column names
colnames(Clinton)
##Structure of data
str(Clinton)
##Head of data
head(Clinton)
tail(Clinton)

#Add New Column, "Location Name"
Location_Name <-rep("clinton", nrow(Clinton))
Clinton <- cbind(Location_Name, Clinton)


#Load Raw Data from Kinston Research Station Site
Kinston <- read_csv("RAW_Kinston.csv")

#Inspect Data
##Column names
colnames(Kinston)
##Structure of data
str(Kinston)
##Head of data
head(Kinston)
tail(Kinston)

#Add New Column, "Location Name"
Location_Name <-rep("kinston", nrow(Kinston))
Kinston <- cbind(Location_Name, Kinston)

#Join tables
Monthly_Weather <- dplyr::full_join(Clinton, Kinston)

#Rename columns
colnames(Monthly_Weather)
Monthly_Weather <- dplyr::rename(Monthly_Weather, "Date" = "Date.Time..EST.", 
                                 "Avg daily air temperature 2m" = "monthly.AVG.of.2m.Average.Daily.Temperature..F.", 
                                 "Daily max air temperature 2m" =  "monthly.AVG.of.2m.Daily.max.air.temperature..F.", 
                                 "Daily min air temperature 2m" = "monthly.AVG.of.2m.Daily.Min.Temperature..F.", 
                                 "Avg daily air temperature 10m" = "monthly.AVG.of.10m.Average.Daily.Temperature..F.", 
                                 "Daily max air temperature 10m" =  "monthly.AVG.of.10m.Daily.max.air.temperature..F.", 
                                 "Daily min air temperature 10m" = "monthly.AVG.of.10m.Daily.Min.Temperature..F.", 
                                 "Heating degree days" = "X2m.Heating.Degree.Days..F.", 
                                 "Cooling degree days" = "X2m.Cooling.Degree.Days..F.", 
                                 "Relative humidity daily average" = "monthly.AVG.of.2m.Relative.Humidity.Daily.Avg..percent.", 
                                 "Daily max relative humidity" = "monthly.AVG.of.2m.Daily.max.Relative.Humidity..percent.", 
                                 "Daily min relative humidity" = "monthly.AVG.of.2m.Daily.min.Relative.Humidity..percent.", 
                                 "Daily precipitation" = "monthly.SUM.of.1m.Daily.Precipitation..in.", 
                                 "Soil temperature daily mean" = , 
                                 "Soil temperature daily min" = , 
                                 "Soil temperature daily max" =, 
                                 "Soil moisture daily average" = , 
                                 "Soil moisture daily min" = , 
                                 "Soil moisture daily max" = )


#Change Date Column from "Character" to "Date" class
