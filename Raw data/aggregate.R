rm(list=ls())
library(dplyr)
library(ggplot2)


load("D:/Litty-One drive TCD/OneDrive - Trinity College Dublin/TCD_PhD/OKEON_HMM/biodivmonit/Raw data/2022_Species_detections.rda")
data<-Species_detections %>% select(Date,Period, Vocalisations)
data$Date<-as.Date(data$Date,format = "%d-%m-%Y")
data<-data%>%arrange(data$Date)
overall_n<-data%>%group_by(Date,Period)%>% summarise(Vocalisations= sum(Vocalisations))%>% ungroup() # Removes the grouping
overall_n$Voc<-c(NA,(log(overall_n$Vocalisations[-1])-log(overall_n$Vocalisations[-length(overall_n$Vocalisations)])))
str(overall_n)

View(overall_n)