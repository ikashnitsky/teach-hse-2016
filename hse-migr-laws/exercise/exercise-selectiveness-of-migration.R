################################################################################
#
# HSE R 05-12-2016 (UPD 11-12-2016)
# Exercise 2. Selectiveness of migration: age and sex
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################

# Erase all objects in memory
rm(list = ls(all = TRUE))

# load required packages
# The code is written and tested on a PC-win7-x64
# R version 3.3.1

# load required packages
library(tidyverse) # version 1.0.0
library(ggthemes) # version 3.2.0
library(haven) # version 1.1.0
library(RColorBrewer) # version 1.1-2
library(viridis) # version 0.3.4
library(stringr)

# set working directory to the one where you have this file
setwd('')

# create sub-directories
ifelse(!dir.exists('out'),dir.create('out'),paste("Directory already exists"))


################################################################################
#  County Characteristics, 2000-2007 ICPSR 20660 dataset
# http://www.icpsr.umich.edu/icpsrweb/NACJD/studies/20660

# unzip the data
unzip('exercise/ICPSR_20660.zip', exdir = 'exercise/data')

df_cc <- haven::read_sav('exercise/data/DS0001/20660-0001-Data.sav')

# extract and calculate sex ratio
df <- df_cc %>% select(FIPS, State, Division, CBSA_Status, Pop04, Male15_44_05, Fmale15_44_05, 
                       RuralUrban03, MedianAge05)
names(df) <- tolower(names(df))

df <- df %>% mutate(asr = male15_44_05 / fmale15_44_05,
                    metro = ifelse(ruralurban03 <= 3, 'Metro', 'Non-metro'))

df$fips <- str_pad(df$fips, 5, 'left', 0)
df$state <- str_pad(paste(df$state),width = 2,side = 'left',pad = '0')




################################################################################
# EXPLORATORY PLOTS


# Adult sex rates
gg_asr_dens <- ggplot(df)+
        geom_density(aes(asr,color=metro)) + 
        scale_color_manual('Type of county', values = brbg[c(2,8)])+
        coord_cartesian(xlim = c(.8,1.4))+
        theme_minimal(base_size = 15) + 
        theme(legend.position = c(.8,.6))+
        ylab('Density')+
        xlab('Adult sex ratio, males to females')

gg_asr_ecdf <- ggplot(df)+
        stat_ecdf(aes(asr,color=metro)) + 
        scale_color_manual('Type of county', values = brbg[c(2,8)])+
        coord_cartesian(xlim = c(.8,1.4))+
        theme_minimal(base_size = 15) + 
        theme(legend.position = c(.8,.6))+
        ylab('Empirical cumulative density')+
        xlab('Adult sex ratio, males to females')

gg_asr <- cowplot::plot_grid(gg_asr_dens,gg_asr_ecdf)

ggsave('out/gg_asr.png', gg_asr, width = 12, height = 5, type="cairo-png")


# meadian age
gg_ma_dens <- ggplot(df)+
        geom_density(aes(medianage05,color=metro)) + 
        scale_color_manual('Type of county', values = brbg[c(2,8)])+
        theme_minimal(base_size = 15) + 
        theme(legend.position = c(.8,.6))+
        ylab('Density')+
        xlab('Median age of the population')

gg_ma_ecdf <-ggplot(df)+
        stat_ecdf(aes(medianage05,color=metro)) + 
        scale_color_manual('Type of county', values = brbg[c(2,8)])+
        theme_minimal(base_size = 15) + 
        theme(legend.position = c(.8,.6))+
        ylab('Empirical cumulative density')+
        xlab('Median age of the population')

gg_ma <- cowplot::plot_grid(gg_ma_dens,gg_ma_ecdf)

ggsave('out/gg_ma.png', gg_ma, width = 12, height = 5, type="cairo-png")
