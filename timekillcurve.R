murine_efflux_data <- read_excel("C:/Users/erhe/Desktop/EFFLUX_MODEL/datasets/murine_efflux_data.xlsx", 
                                 +     sheet = "df", col_types = c("text", "text", 
                                                                   +         "numeric", "numeric", "numeric", 
                                                                   +         "numeric", "numeric"))
library(tidyverse)

#Not time-series data so plot histogram depicting the changes in CFU? 


