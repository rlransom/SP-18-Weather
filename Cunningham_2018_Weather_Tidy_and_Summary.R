###############################################################
##Hourly Weather Data for 2018 SP Growing Season - Kinston
###############################################################

#Tidy Data and Create Summary Statistics

###############################################################


#Load necessary packages
#install.packages("tidyverse")
#install.packages("naniar")
library("tidyverse")
library("dplyr")
library("readr")
library("readxl")
library("naniar")
library("lubridate")

#Load Local Raw Data
Cinningham18<- read_excel("./Raw_Data/Readable_Cunningham_Weather_2018.xlsx")

Data <- Cunningham18


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
names <- colnames(Data)[-1]
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

#Keep a copy to use later
Data_with_weeks <- Data %>%
  mutate(Week = lubridate::week(Date))



#Select columns to take sum
s <- Data %>%
  select(Week, Precipitation)%>%
  na.omit()
#Sum by week
s <- s %>%
  group_by(Week)%>%
  summarise_all(sum, na.rm=TRUE)


#Select columns to take average
names <- colnames(Data)
bye <- match(c("Date", "Precipitation", "Week"), names)
names <- names[-c(bye)]

a <- Data %>%
  select(Week, names)

#Average by week
a <- a %>%
  group_by(Week)%>%
  summarize_all(mean, na.rm=TRUE)
a <- round(a, digits = 2)

##Combine averaged and summarized dataframes into one dataframe
Data <- full_join(a,s, by= "Week")

#Add location and year column
Year <- "2018"
Year <- rep(Year, nrow(Data))
Data <- cbind(Year, Data)
#Enter the location the data was collected from
Location <- "Cunningham"
Location <- rep(Location, nrow(Data))
Data <- cbind(Location, Data)

Data <- as.data.frame(Data)

####################################
#Reformat Data
#Kinston 2018 Planting date: June 14, 2018. The 24th week of 2018.
#Remove weeks before this
Data <- Data %>%
  filter(Week >= 24)
Data_with_weeks <- Data_with_weeks %>%
  filter(Week >= 24)


#Kinston 2018 Harvest ended in week 42
Data <- Data %>%
  filter(Week <= 42)
Data_with_weeks <- Data_with_weeks %>%
  filter(Week <= 42)

#Week column should signifity weeks since planting week, so subtract 24 frome each
Data$Week <- Data$Week - 24
Data_with_weeks$Week <- Data_with_weeks$Week - 24



#Remove Temp avg b/c it's same as temp DB
data <- Data[-5,]

################################


##Export tidied data
#write_csv(Data, path = "Exported_Data/Tidy_Kinston_Weather_2018.csv")



#################################

#Summary Statistsics
summary(Data)

#We want prettier summary
#Install and load skimr
###install.packages("skimr")
library(skimr)
library(ggplot2)

skim(Data)

#Temperature
Temperature <- Data$Air_Temp_DB
#Summary Statistics
summary(Temperature)
#Make histogram
ggplot(Data, aes(x=Air_Temp_DB))+
  geom_histogram(binwidth=5, fill="Grey", color="black")+
  ggtitle("2018 Kinston Temperature Histogram")+
  xlab("Air Temperature (F)")+
  ylab("Frequency (Weeks)")+
  theme_bw()
#Make Boxplot
ggplot(Data_with_weeks, aes(x=Week, y=Air_Temp_DB, group=Week))+
  geom_boxplot()+
  ggtitle("2018 Kinston Temperature Boxplot")+
  xlab("Week Since Planting")+
  ylab("Air Temperature (F)")+
  theme_bw()

#Soil Moisture
Soil_Moisture <- Data$Soil_Moisture_Avg
#Summary Statistics
summary(Soil_Moisture)
#Make histogram
ggplot(Data, aes(x=Soil_Moisture_Avg))+
  geom_histogram(binwidth=.05, fill="Grey", color="black")+
  ggtitle("2018 Kinston Soil Moisture Histogram")+
  xlab("Soil Moisture (m3/m3)")+
  ylab("Frequency (Weeks)")+
  theme_bw()
#Make Boxplot
ggplot(Data_with_weeks, aes(x=Week, y=Soil_Moisture_Avg, group=Week))+
  geom_boxplot()+
  ggtitle("2018 Kinston Weekly Mean Soil Moisture Boxplots")+
  xlab("Week Since Planting")+
  ylab("Soil Moisture (m3/m3)")+
  theme_bw()
