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
library("dplyr")
library("readr")
library("readxl")
library("naniar")
library("lubridate")

#Load Raw Data
Clinton18<- read_excel("./Raw_Data/Readable_Clinton_Weather_2018.xlsx")
Clinton19 <- read_excel("./Raw_Data/Readable_Clinton_Weather_2019.xlsx")
Cunningham18 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2018.xlsx")
Cunningham19 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2019.xlsx")




# #Create our Dataframe to work with
# ##Add Location column to each table
# 
#Clinton 2018
#Add "Location" Column
Location <- "Clinton"
Location <- rep(Location, nrow(Clinton18))
Clinton18 <- cbind(Location, Clinton18)
#Re-order Columns
Clinton18 <- Clinton18[,c(2,1,3:18)]

#Temporary
Data <- Clinton18


# 
# #Clinton 2019
# #Add "Location" Column
# Location <- "Clinton"
# Location <- rep(Location, nrow(Clinton19))
# Clinton19 <- cbind(Location, Clinton19)
# #Re-order Columns
# Clinton19 <- Clinton19[,c(2,1,3:18)]
# 
# #Cunningham 2018
# #Add "Location" Column
# Location <- "Cunningham"
# Location <- rep(Location, nrow(Cunningham18))
# Cunningham18 <- cbind(Location, Cunningham18)
# #Re-order Columns
# Cunningham18 <- Cunningham18[,c(2,1,3:18)]
# 
# #Cunningham 2019
# #Add "Location" Column
# Location <- "Cunningham"
# Location <- rep(Location, nrow(Cunningham19))
# Cunningham19 <- cbind(Location, Cunningham19)
# #Re-order Columns
# Cunningham19 <- Cunningham19[,c(2,1,3:18)]
# 
# ##Combine data with same year
# ##2018 hard wired for now, will make this user defined later
# Data <- bind_rows(Clinton18, Cunningham18)



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
names <- colnames(Data)[-c(1:2)]
Data <- Data %>%
  mutate_at(names, as.numeric)

#Express percentages as fractions
Data <- Data %>%
  mutate(Relative_Humidity = Relative_Humidity/100)

##Aggregate into weekly observations
#Note that for some parameters we wish to find the average (Temperature) but for others we need to find the sumn (percipitation)
#Add week column
Data <- Data %>%
  mutate(Week = lubridate::week(Date))
#Select columns to take sum
s <- Data %>%
  select(Week, Hourly_Precipitation)%>%
  na.omit()
#Sum by week
s <- aggregate(s$Hourly_Precipitation, by=list(Week=s$Week), FUN=sum)

#Select columns to take average
names <- colnames(Data)
bye <- match(c("Date", "Location", "Hourly_Precipitation", "Week"), names)
names <- names[-c(bye)]

a <- Data %>%
  select(Week, names)%>%
  na.omit()
#Issue- na.omit is causing us to lose the last two weeks since heat index is empty for those weeks. 


#Average by week
Aa <- aggregate(. ~ Week, a, mean)
  
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
