###############################################################
##Monthly Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweetpotatoes?

###############################################################
#Clear Environment
remove(list = ls())

#Load necessary packages
install.packages("tidyverse")
library(readr)

#Load Raw Data from Clinton Research Station Site
Clinton <- read_csv("RAW_Clinton18_Monthly.csv")

#Add location identifier
Location_Name <-rep("clinton", nrow(Clinton))
Clinton <- cbind(Location_Name, Clinton)

#Load Raw Data from Kinston Research Station Site
Kinston <- read_csv("RAW_Kinston18_Monthly.csv")

#Add location identifier
Location_Name <-rep("kinston", nrow(Kinston))
Kinston <- cbind(Location_Name, Kinston)

#Create combined data table
Monthly_Weather <- dplyr::full_join(Clinton, Kinston)

#Inspect Data
##Column names
colnames(Monthly_Weather)
##Structure of data
str(Monthly_Weather)
##Head/Tail of data
head(Monthly_Weather)
tail(Monthly_Weather)


#Change Date Column from "Character" to "Date" class
