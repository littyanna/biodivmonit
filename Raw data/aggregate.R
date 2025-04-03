rm(list=ls())
library(dplyr)
library(ggplot2)


load("C:/Users/litty/OneDrive - Trinity College Dublin/TCD_PhD/Caroline weekily meeting/2024/12. December/OKEON paper_final r codes_01122024/biodivmonit/Raw data/2022_Species_detections.rda")
data<-Species_detections %>% select(Date,Period, Vocalisations)
data$Date<-as.Date(data$Date,format = "%d-%m-%Y")
data<-data%>%arrange(data$Date)
overall_n<-data%>%group_by(Date,Period)%>% summarise(Vocalisations= sum(Vocalisations))%>% ungroup() # Removes the grouping
overall_n$voc<-c(NA,(log(overall_n$Vocalisations[-1])-log(overall_n$Vocalisations[-length(overall_n$Vocalisations)])))
overall<-na.omit(overall_n)
str(overall)

#write.csv(overall, "D:/Litty-One drive TCD/OneDrive - Trinity College Dublin/TCD_PhD/Caroline weekily meeting/2024/9. September/To silvia - HMM materials/OKEON old paper R pgms latest/Updated r codes_okeon old_140924/okeon_old.csv")
