################################################################################
#                                                                                                        
# Initial R setup 30-11-2016
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#                                                                                                    
################################################################################

# To run the code, select it and press CTRL+ENTER

# Define R_HOME and library ---------------------------------------------------
dir.create("/R_home/pgks", recursive = T)

Sys.setenv(R_USER = "/R_home") # set the R_home
.libPaths('/R_home/pgks') # set base library
# These two lines of code are to be executed in each R session
# To do this automatically, we'll add the lines to ".Rprofile"
file.edit("/usr/lib/R/library/base/R/Rprofile") # just copy them 


# Now install packages --------------------------------------------------------
pkgs <- c('tidyverse', 
          'ggthemes',
          'viridis',
          'cowplot',
          # maps
          'rgdal',
          'rgeos',
          'maptools',
          'RColorBrewer',
          # data
          'eurostat',
          'wpp2015',
          'HMDHFDplus',
          'figshare',
          'gapminder',
          'acs',
          # utils
          'bookdown',
          'rmarkdown',
          'texreg',
          'microbenchmark',
          'swirl'
          )


install.packages(pkgs, dependencies = TRUE) # be patient - it will take a while
