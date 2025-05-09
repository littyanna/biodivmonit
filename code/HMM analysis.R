## Here is the R code for the final models

rm(list=ls())
library(dplyr)
library(hmmTMB) # R package for fitting hidden markov models
library(ggplot2)

load("D:/Litty-One drive TCD/OneDrive - Trinity College Dublin/TCD_PhD/OKEON_HMM/biodivmonit/data for HMM analysis/Data_hmm.rda")

str(Data_hmm)

head(Data_hmm)
## 3- state zero mean constrained HMM (3C model)

set.seed(10)
#List of best initial parameter values
par3c<- list(Voc = list(mean = c(0,0,0), sd = c(0.3862733, 0.2576610, 0.7226931)))
#Define the hidden state process
hid3c<-MarkovChain$new(data=Data_hmm,n_states = 3)
#Define the observation process
obs3c <- Observation$new(data = Data_hmm,
                         dists = list(Voc = "norm"),
                         par = par3c,
                         n_states = 3)

#To constrain the mean of the gaussian distribution in each state to zero
fixpar3c<-list(obs=c("Voc.mean.state1.(Intercept)"=NA,"Voc.mean.state2.(Intercept)"=NA, "Voc.mean.state3.(Intercept)"=NA))
#Create HMM object using observation and hidden state components
hmm3c<-HMM$new(obs=obs3c,hid=hid3c,fixpar = fixpar3c)
#fitting HMM
hmm3c$fit(silent=F, itnmax= 10000, control = list("maxit"=10000), method="BFGS")
hmm3c$out() 

####################################################################################################


#Plot as in Fig.5a 

#Extract the viterbi-decoded states
states <- factor(hmm3c$viterbi(), levels = c("2", "1", "3"))

Data_hmm$State <- states

# Define state colors
state_colors <- c("1" = "#FFC107", "2" = "#009E73", "3" = "#FF0000")  # Warning, Normal, Disturbance

typhoon_legend <- data.frame(
  Typhoon = factor(c("Trami", "Kong-Rey"), levels = c("Trami", "Kong-Rey")),
  Date = as.Date(c("2018-09-29", "2018-10-05"))
)

ggplot(Data_hmm, aes(x = Date, y = Voc)) +
  geom_line(color = "black") +
  geom_vline(data = typhoon_legend, aes(xintercept = Date, color = Typhoon),
             linetype = "dashed", size = 0.6, show.legend = FALSE) +
  geom_point(aes(color = State), size = 1) +
  

  scale_color_manual(
    name = "States",  
    values = c(state_colors, "Trami" = "#FD8D3C", "Kong-Rey" = "purple"),
    breaks = c("2", "1", "3"),
    labels = c("Normal", "Warning", "Disturbed")
  ) +

  scale_x_date(
    date_breaks = "5 days",
    date_labels = "%d-%b"
  ) +

  labs(
    x = "Date",
    y = "Log Change in Vocalisations"
  ) +

  theme_minimal() +
  theme(
    axis.text.x = element_text(size=7, angle = 45, hjust = 0.8),
    axis.text.y = element_text(size=7, hjust = 0.8),
    legend.title = element_text(size = 9),
    legend.text = element_text(size = 7),
    axis.title.x = element_text(size=7),
    axis.title.y = element_text(size=7),
    strip.text = element_text(size = 6),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    axis.line = element_line(color = "black") 
  )
##############################################################################################

#In-sample model selection : 1. Adjusted BIC calculation
## Adjusted BIC for the model
BIC_3c_adj=-2*hmm3c$llk()+11*log(66/(2*pi))
BIC_3c_adj

# In sample-model selection: 2. Absolute error between true and simulated statistics based on posterior predictive checks

set.seed(20)
gof<-function(Data_hmm){
  s<-c(quantile(Data_hmm$Voc,seq(0,1,by=0.25)),autocor=cor(Data_hmm$Voc[-1],Data_hmm$Voc[-nrow(Data_hmm)],use = "complete.obs"))
}

# Run posterior predictive checks
checks_3c<-hmm3c$check(check_fn = gof, silent = T, nsims = 2000)

# Plot histograms of simulated statistics
checks_3c$plot


# Calculate the median of each simulated statistic
median_simulated_stats <- apply(checks_3c$stats, 1, median)

# Derive the observed statistics of the data
observed_stats <- checks_3c$obs_stat

# Compare observed statistics with median of the simulated statistics
comparison_3c <- data.frame(
  Observed = observed_stats, 
  Median_Simulated = median_simulated_stats
)

# Calculate the absolute difference between observed and median simulated statistics
comparison_3c$Abs_Diff_Median <- abs(comparison_3c$Observed - comparison_3c$Median_Simulated)
comparison_3c

########################################################################################################

## 3 state mean constraint model with precipitation: 3C_p
par3c_p <- list(Voc = list(mean = c(0,0,0), sd = c(0.4051870, 0.2268517, 0.7426536)))
#Incorporate scaled mean precipitation to the transition probability matrix
hid3c_p<-MarkovChain$new(data=Data_hmm,n_states = 3,formula = ~Precip_z)
obs3c_p <- Observation$new(data = Data_hmm,
                         dists = list(Voc = "norm"),
                         par = par3c_p,
                         n_states = 3)
fixpar3c_p<-list(obs=c("Voc.mean.state1.(Intercept)"=NA,"Voc.mean.state2.(Intercept)"=NA, "Voc.mean.state3.(Intercept)"=NA))
hmm3c_p<-HMM$new(obs=obs3c_p,hid=hid3c_p,fixpar = fixpar3c_p)
hmm3c_p$fit(silent=F, itnmax= 20000, control = list("maxit"=20000), method="BFGS")
hmm3c_p$out()
hmm3c_p$viterbi()

###########################################################################################################



