The daily species detection data aggregated across species and study sites. 

Data Structure: 
Data_hmm.rda

Date: Date representing days from 31/08/2018 and 04/11/2018
Period: Categorisations in study period (Pre-typhoon; Trami; Post-trami; Kong-rey; Post-typhoon).
Vocalisations: Aggregated daily vocalisation counts across all three focal species and 24 study sites
Voc: Outcome variable, Log change in vocalisations between two consecutive days. 
The code for creating the variables Vocalisations and Voc are given in aggregate.R file in the Raw data folder. The value of voc for 30/08/2018 is NA and is excluded in this dataset (as Voc is the log difference in vocalisations between two consecutive days). 

Mean_precip: Mean of total precipitation across 6 weather stations close to the study sites. 
Avg_wind: Mean of the average wind speed across 6 weather stations close to the study sites.
Wind_log_ch: Log difference in 'Avg_wind' between two days. This variable is considered for non homogeneous HMMs with wind speed as covariate.
Precip_z: Z transformation applied to the 'Mean_precip' variable. 

