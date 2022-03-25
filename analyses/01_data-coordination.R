# ################################################
# Automating data and code upload to OSF.  
library(pacman)
p_load(osfr, readr, dplyr)


# Location
# read your token!
osf_pat <- readr::read_file("osf_pat.txt")
osf_auth(osf_pat)

project <- osf_retrieve_node("7msd8")

project

project %>%
  osf_ls_nodes()


# Data upload
upload_location <- project %>%
  osf_ls_nodes() %>%
  filter(name == "Data")

upload_location

osf_upload(upload_location, 
           path = "data-raw", 
           recurse = TRUE,
           progress = TRUE,
           conflicts = "overwrite")

osf_upload(upload_location, 
           path = "data", 
           recurse = TRUE,
           progress = TRUE,
           conflicts = "overwrite")


# Analysis
upload_location <- project %>%
  osf_ls_nodes() %>%
  filter(name == "Analysis")

# Rmd
osf_upload(upload_location, 
           path = "analyses", 
           conflicts = "overwrite")
# html
osf_upload(upload_location, 
           path = "docs", 
           conflicts = "overwrite")
