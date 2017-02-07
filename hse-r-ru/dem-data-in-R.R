################################################################################
#                                                                                                        
# HSE R 13-12-2016
# Demographic data in R
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#                                                                                                    
################################################################################

# Erase all objects in memory
rm(list = ls(all = TRUE))

# !!!ONLY IF NEEDED!!!
# install the data packages
pkgs <- c('eurostat',
        'wpp2015',
        'HMDHFDplus',
        'gapminder',
        'acs',
        'OECD',
        'WDI')

install.packages(pkgs, dependencies = TRUE)


################################################################################
# load the packages
library(tidyverse)
library(ggthemes)
library(viridis)



################################################################################
# GAPMINDER

library(gapminder)

df_gap <- gapminder::gapminder

df <- df_gap %>% select(1:4) %>% 
        filter(year %in% c(1957, 1982, 2007))

ggplot(df) +
        stat_ecdf(aes(x = lifeExp, color = factor(year)))

################################################################################
# EUROSTAT

library(eurostat)


search_eurostat('fertility')

df_es <- get_eurostat('tsdde220', time_format = 'num')

df_fert <- get_eurostat('demo_r_frate3', time_format = 'num')

spatial <- get_eurostat_geospatial()


################################################################################
# UN WORLD POPULARION PROSPECTS

library(wpp2015)

data(tfr)

df_long <- tfr %>% gather('period', 'value', 3:16)



################################################################################
# HUMAN MORTALITY DATABASE

library(HMDHFDplus)

countries <- getHMDcountries()

hmd_login <- "your-HMD-login"
hmd_pass <- "your-HMD-password"
# you can store this data in ".Renviron" or ".Rptofile". For more info read:
# https://csgillespie.github.io/efficientR/3-3-r-startup.html#r-startup

rus <- readHMDweb(CNTRY = 'RUS', item = 'bltper_1x1',
                  username = hmd_login, 
                  password = hmd_pass)



################################################################################
# Organisation for Economic Co-operation and Development

library(OECD)

search_dataset("unemployment")

df_oecd <- get_dataset('DUR_D') # it took full 3 mins at my machine

# for more instruction check out
vignette("oecd_vignette_main")

################################################################################
# World Bank's World Development Indicators

library(WDI)

WDIsearch("fertility")

df_wdi <- WDI(indicator = "SP.DYN.TFRT.IN")


################################################################################
## American Community Survey

library(acs)
library(tmap) # has nice functionality to easily map ACS data

# Watch an example here
#http://stackoverflow.com/a/34453890/4638884