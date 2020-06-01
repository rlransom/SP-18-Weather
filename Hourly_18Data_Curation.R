###############################################################
##Hourly Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweetpotatoes?

###############################################################
#Clear Environment
remove(list = ls())

#Load necessary packages
install.packages("tidyverse")
library("readr")
library("readxl")

#Load Hourly Data from Clinton Research Station Site
Clinton <- read_excel("Processed_Clinton18_Hourly.xlsx")

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

#Replace character entries with NA
replace_with_na_if()
