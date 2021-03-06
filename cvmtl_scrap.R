library(rvest)
library(dplyr)
library(stringr)

url <- 'https://santemontreal.qc.ca/population/coronavirus-covid-19/situation-du-coronavirus-covid-19-a-montreal/'

file_name <- paste0('mtl_data/', Sys.Date() - 1, '.csv')

tbl <- read_html(url) %>% 
       html_nodes("table") %>%
       html_table() %>%
       .[[4]] %>%
       select(c(1,5)) %>%
       rename('Arrondissements' = 1, 'Cas Confirm��s' = 2) %>%
       mutate('Cas Confirm��s' = str_replace_all(.[[2]], ' ', ''))

tbl[34, 1] <- 'Territoire �� confirmer'

readr::write_csv(tbl, file = file_name)
