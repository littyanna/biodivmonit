# biodivmonit

Repository for data and code to reproduce hidden Markov model analyses for the work  'A general hidden Markov model framework for capturing changes in species behaviour under disturbance in acoustic time series'

'Raw data' folder includes .rda data for bird species detections.  Data structure is described in the corresponding README file. The R code to aggrgate the species detections across species and sites on  a daily temporal resolution, which is used for the analysis is given in 'aggregate.R'. The 'data for HMM analysis' folder include the data used for the analysis with descriptions of variables in the corresponding README file. Code folder contains R script (HMM analysis.R) for analysing the data using the HMM framework in the paper. The code for running mean constrained (3C) and mean constrained model with precipitation (3C_P) is included. 
