###############################################################
##Hourly Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweetpotatoes?

###############################################################
#Clear Environment
remove(list = ls())

#Load necessary packages
#install.packages("tidyverse")
#install.packages("naniar")
library("tidyverse")
library("readr")
library("readxl")
library("naniar")
library("lubridate")

#Load Hourly Data from Clinton Research Station Site
Clinton <- read_excel("RFriendly_Clinton18_Hourly.xlsx")

#Inspect Data
##Column names
colnames(Clinton)
##Structure of data
str(Clinton)
##Head/Tail of data
head(Clinton)
tail(Clinton)
##Summarize
summary(Clinton)


#Replace character entries ("missing") with NA
Clinton <- naniar::replace_with_na_if(Clinton, .predicate = is.character, condition = ~.x %in% ("missing"))

#Change column type to numeric
names <- colnames(Clinton)[c(-1)]
Clinton <- Clinton %>%
  mutate_at(names, as.numeric)

#Summarize
summary(Clinton)
#We now see some basic stats about each variable


#Preliminary Visualization
Clinton %>%
  ggplot() +
  geom_point(mapping = aes(x = DateTime, y = Air_Temp_Avg)) +
  xlab("Date") +
  ylab("Temperature (F)") +
  ggtitle("Average Temperature")+
  theme_light()
