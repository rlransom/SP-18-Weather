#Weather Summary Statistics

###################3
#Clinton 2018


#Load Clinton18
Clinton18 <-read.csv('./Exported_Clinton18/Tidy_Clinton_Weather_2018.csv')

#Summary Statistsics
summary(Clinton18)

#We want prettier summary
#Install and load skimr
###install.packages("skimr")
library(skimr)
library(ggplot2)

skim(Clinton18)

#Temperature
Temperature <- Clinton18$Air_Temp_DB
#Summary Statistics
summary(Temperature)
#Make histogram
ggplot(Clinton18, aes(x=Air_Temp_DB))+
  geom_histogram(binwidth=5, fill="Grey", color="black")+
  ggtitle("2019 Temperature Histogram")+
  xlab("Air Temperature (F)")+
  ylab("Frequency (Weeks)")+
  theme_bw()
#Make Boxplot
ggplot(Clinton18_with_weeks, aes(x=Week, y=Air_Temp_DB, group=Week))+
  geom_boxplot()+
  ggtitle("2019 Temperature Boxplot")+
  xlab("Week Since Planting")+
  ylab("Air Temperature (F)")+
  theme_bw()

#Soil Moisture
Soil_Moisture <- Clinton18$Soil_Moisture_Avg
#Summary Statistics
summary(Soil_Moisture)
#Make histogram
ggplot(Clinton18, aes(x=Soil_Moisture_Avg))+
  geom_histogram(binwidth=.05, fill="Grey", color="black")+
  ggtitle("2019 Soil Moisture Histogram")+
  xlab("Soil Moisture (m3/m3)")+
  ylab("Frequency (Weeks)")+
  theme_bw()
#Make Boxplot
ggplot(Clinton18_with_weeks, aes(x=Week, y=Soil_Moisture_Avg, group=Week))+
  geom_boxplot()+
  ggtitle("2019 Weekly Mean Soil Moisture Boxplots")+
  xlab("Week Since Planting")+
  ylab("Soil Moisture (m3/m3)")+
  theme_bw()