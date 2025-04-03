##Here is the R code for the final models

##Three state mean constraint model

rm(list=ls())
library(dplyr)
library(hmmTMB) # R package for fitting hidden markov models
library(ggplot2)

load("D:/Litty-One drive TCD/OneDrive - Trinity College Dublin/TCD_PhD/OKEON_HMM/biodivmonit/data for HMM analysis/Data_hmm.rda")
View(Data_hmm)

str(Data_hmm)


##To fit a 3- state standard HMM

set.seed(10)

#Provide initial values for mean and standard deviation per state
par3s <- list(Voc = list(mean = c(-1.1010790, -0.0726868,  0.3844790), sd = c(0.5830050, 0.3905911, 1.3805335)))# Initial values selected from 200 HMM models based on best BIC value

#Define the observation process
obs3s <- Observation$new(data = Data_hmm,
                         dists = list(Voc = "norm"),
                         par = par3s,
                         n_states = 3)

# Suggest initial parameters
par3s<-obs3s$suggest_initial()
obs3s$update_par(par = par3s)
# The hidden state process is stored as a Markovchain object in hmmTMB. 
hid3s<-MarkovChain$new(data=Data_hmm,n_states = 3)
#Mention the observation distribution
dists<-list(Voc="norm")

#create  observation model object
obs3s<-Observation$new(data=Data_hmm,n_states = 3,dists = dists,par=par3s)
hmm3s<-HMM$new(obs=obs3s,hid=hid3s)
hmm3s$fit(silent=F, itnmax= 10000, control = list("maxit"=10000))

hmm3s$coeff_fe()
llk3s<-hmm3s$llk()
llk3s
# The BIC for 3 state standard HMM
(BIC_cal3s<--2*llk3s+14*log(66))

#The adjusted BIC for 3 state standard HMM
(BIC_cal3s_adj<--2*llk3s+14*log(66/(2*pi)))

## 3- state zero mean constraint HMM

set.seed(10)
#par3b <- list(voc = list(mean = c(0,0,0), sd = c(0.15,0.45,0.6)))#used for small SE and CI

par3b <- list(Voc = list(mean = c(0,0,0), sd = c(0.3862733, 0.2576610, 0.7226931)))# from 100 simulation
hid3b<-MarkovChain$new(data=Data_hmm,n_states = 3)
obs3b <- Observation$new(data = Data_hmm,
                         dists = list(Voc = "norm"),
                         par = par3b,
                         n_states = 3)

fixpar3b<-list(obs=c("Voc.mean.state1.(Intercept)"=NA,"Voc.mean.state2.(Intercept)"=NA, "Voc.mean.state3.(Intercept)"=NA))

hmm3b<-HMM$new(obs=obs3b,hid=hid3b,fixpar = fixpar3b)
#hmm3b$fit(silent=F)

#hmm3b$fit(silent=F, itnmax= 10000, control = list("maxit"=10000))
hmm3b$fit(silent=F, itnmax= 10000, control = list("maxit"=10000), method="BFGS")# for CI and SE, both give same BIC
hmm3b$out()

##plot


# Add states from hmm3b to the `oke2` dataset
Data_hmm$State <- factor(hmm3b$states(), levels = c("2", "1", "3"))  # Ensure correct order

# Define state colors
state_colors <- c("1" = "#FFC107", "2" = "#009E73", "3" = "#FF0000")  # Warning, Normal, Disturbance

# Typhoon legend data
typhoon_legend <- data.frame(
  Typhoon = factor(c("Trami", "Kong-Rey"), levels = c("Trami", "Kong-Rey")),
  Date = as.Date(c("2018-09-29", "2018-10-05"))
)

# Plot
ggplot(oke2, aes(x = Date, y = Voc)) +
  # Add lines for vocalization changes
  geom_line(color = "black") +
  # Add vertical lines for typhoons with separate colors
  geom_vline(data = typhoon_legend, aes(xintercept = Date, color = Typhoon),
             linetype = "dashed", size = 0.6, show.legend = FALSE) +
  # Add points with state colors
  geom_point(aes(color = State), size = 1) +
  
  # Legend for states
  scale_color_manual(
    name = "States",  # Heading for the States legend
    values = c(state_colors, "Trami" = "#FD8D3C", "Kong-Rey" = "purple"),
    breaks = c("2", "1", "3"),
    labels = c("Normal", "Warning", "Disturbed")
  ) +
  # Format the x-axis for dates
  scale_x_date(
    date_breaks = "5 days",
    date_labels = "%d-%b"
  ) +
  # Update axis labels
  labs(
    x = "Date",
    y = "Log Change in Vocalisations"
  ) +
  # Minimal theme with adjustments
  theme_minimal() +
  theme(
    axis.text.x = element_text(size=7, angle = 45, hjust = 0.8),
    axis.text.y = element_text(size=7, hjust = 0.8),
    legend.title = element_text(size = 9),  # Add legend title
    legend.text = element_text(size = 7),
    axis.title.x = element_text(size=7),
    axis.title.y = element_text(size=7),
    strip.text = element_text(size = 6),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),  # Add border
    axis.line = element_line(color = "black")  # Add axis lines
  )


## posterior predictive checks
# Step 1: Extract the observed statistics
obs_stat <- checks_3b$obs_stat

# Step 2: Extract simulated statistics
simulated_stats <- checks_3b$stats

# Step 3: Compute deviations (absolute difference) for all simulations
deviations <- abs(simulated_stats - obs_stat)

# Step 4: Calculate the mean absolute error for each simulation
(abs1_2a <- round(rowMeans(deviations), 4))
# Step 1: Compute squared deviations
squared_deviations <- (simulated_stats - obs_stat)^2

# Step 2: Compute MSE for each statistic
(mse <- round(rowMeans(squared_deviations),4))

# second approch. mean of statistics across simulations and take absolute deviation from original.(Implimented first)
# Step 1: Compute the mean of each statistic across simulations
mean_simulated_stats <- rowMeans(simulated_stats)

# Step 2: Compute absolute deviation from the observed statistic
(abs2 <- round(abs(mean_simulated_stats - obs_stat), 4))



