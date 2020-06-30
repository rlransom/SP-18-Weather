###############################################################
##Hourly Weather Data for 2018 SP Growing Season - Clinton and Kinston
###############################################################

#Driving Question: What weather factors greatly impact the shape and growth of sweetpotatoes?

#Clean data and generate summary statistics

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

#Load Raw Data
Clinton18 <- read_excel("./Raw_Data/Readable_Clinton_Weather_2018.xlsx")
Clinton19 <- read_excel("./Raw_Data/Readable_Clinton_Weather_2019.xlsx")
Cunningham18 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2018.xlsx")
Cunningham19 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2019.xlsx")

#Choose which file to tidy
Data <- Clinton18


#####################
##Initial Inspection
#Column names
colnames(Data)
#Structure of data
str(Data)
#Head/Tail of data
head(Data)
tail(Data)
#Summarize
summary(Data)

######################
##Dealing with Missing Values
#Replace character entries ("missing") with NA
Data <- naniar::replace_with_na_if(Data, .predicate = is.character, condition = ~.x %in% ("missing"))



######################
##Data Processing
#Change column type to numeric
names <- colnames(Data)[c(-1)]
Data <- Data %>%
  mutate_at(names, as.numeric)

#Add "Location" Column
Location <- "Clinton"
Location <- rep(Location, nrow(Data))
Data <- cbind(Location, Data)
#Re-order Columns
Data <- Data[,c(2,1,3:18)]

#Express percentages as fractions
Data <- Data %>%
  mutate(Relative_Humidity = Relative_Humidity/100)

##Aggregate into weekly observations
#Create day, month, and year columns with function
OrganizeDateColumns <-  



  
  
  
  
######################
#Summary statistics
summary(Data)
#We now see some basic stats about each variable


#Preliminary Visualization
Clinton %>%
  ggplot() +
  geom_point(mapping = aes(x = DateTime, y = Air_Temp_Avg)) +
  xlab("Date") +
  ylab("Temperature (F)") +
  ggtitle("Average Temperature")+
  theme_light()
