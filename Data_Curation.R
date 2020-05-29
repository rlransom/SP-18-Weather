###############################################################
##Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweet potatoes?

###############################################################

#Load necessary packages
#install.packages("tidyverse")
#Clear Envieronment
remove(list = ls())


#Load Raw Data from Clinton Research Station Site
Clinton <- read.csv("RAW_Clinton.csv")

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
Kinston <- read.csv("RAW_Kinston.csv")

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

#Change Date Column from "Character" to "Date" class
