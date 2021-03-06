###############################################################
##Hourly Weather Data for 2018/2019 SP Growing Season - Clinton and Kinston
###############################################################

#Tidy Data

###############################################################
#Clear Environment
remove(list = ls())
#Install Packages manager
if (!require("pacman")) install.packages("pacman")
#Load Packages
pacman::p_load(
  pacman,        
  tidyverse,
  dplyr,
  readr,
  readxl,
  naniar,
  lubridate
)


#Load Raw Data
Clinton18<- read_excel("./Raw_Data/Readable_Clinton_Weather_2018.xlsx")
Clinton19 <- read_excel("./Raw_Data/Readable_Clinton_Weather_2019.xlsx")
Cunningham18 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2018.xlsx")
Cunningham19 <- read_excel("./Raw_Data/Readable_Cunningham_Weather_2019.xlsx")



#####################
#Choose Which of the data files to tidy
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
take_sum <- Data %>%
  select(Week, Precipitation)%>%
  na.omit()
#Sum by week
take_sum <- take_sum %>%
  group_by(Week)%>%
  summarise_all(sum, na.rm=TRUE)


#Select columns to take average
names <- colnames(Data)
bye <- match(c("Date", "Precipitation", "Week"), names)
names <- names[-c(bye)]

take_mean <- Data %>%
  select(Week, names)

#Average by week
take_mean <- take_mean %>%
  group_by(Week)%>%
  summarize_all(mean, na.rm=TRUE)
#Round
take_mean <- round(take_mean, digits = 2)

##Combine averaged and summarized dataframes into one dataframe
Data <- full_join(a,s, by= "Week")

#Add location and year column
Year <- "2018"
Year <- rep(Year, nrow(Data))
Data <- cbind(Year, Data)
#Enter the location the data was collected from
Location <- "Clinton18"
Location <- rep(Location, nrow(Data))
Data <- cbind(Location, Data)

Data <- as.data.frame(Data)

####################################
#Reformat Data
#Clinton 2018 Planting date: June 14, 2018. The 24th week of 2018.
#Remove weeks before this
Data <- Data %>%
  filter(Week >= 24)
Data_with_weeks <- Data_with_weeks %>%
  filter(Week >= 24)


#Clinton 2018 Harvest ended in week 42
Data <- Data %>%
  filter(Week <= 42)
Data_with_weeks <- Data_with_weeks %>%
  filter(Week <= 42)

#Week column should signifity weeks since planting week, so subtract 24 frome each
Data$Week <- Data$Week - 24
Data_with_weeks$Week <- Data_with_weeks$Week - 24

Clinton18_with_weeks <- Data_with_weeks
write_csv(Data, path = "./Raw_Data/2018Clinton_with_weeks.csv")


#Remove Temp avg b/c it's same as temp DB
data <- Data[-5,]

#########################


##Export tidied data
write_csv(Data, path = "Exported_Data/Tidy_Cunningham_Weather_2019.csv")

