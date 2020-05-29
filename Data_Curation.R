###############################################################
##Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greately impact the shape and growth of sweet potatoes?

###############################################################

#Load necessary packages
#install.packages("tidyverse")



#Load Raw Data from Clinton Research Station Site
Clinton <- read.csv("RAW_Clinton.csv")
#Load Raw Data from Kinston Research Station Site
Kinston <- read.csv("RAW_Kinston.csv")

#Join tables
Monthly_Weather <- full_join(Clinton, Kinston)

#Filter out dates before June 2018
  
  