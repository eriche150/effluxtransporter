#Percent Change from Control
murine_efflux_data <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/UNC PKPD/effluxtransporter/data/murine_efflux_data.xlsx", 
                                 sheet = "df", col_types = c("text", "text", 
                                                             "numeric", "numeric", "numeric", 
                                                             "numeric", "numeric"))

#log transform values
murine_efflux_data <- murine_efflux_data %>% 
        mutate(logCFU_mL = log(CFU_mL))
#calculate mean & standard deviation for 1 point: 1 time w error bars graph 
murine_efflux_data<- murine_efflux_data %>% 
        group_by(Treatment,Time_hrs) %>% 
        mutate(avgCFU=mean(logCFU_mL)) %>% 
        mutate(var=sd(logCFU_mL)) #standard deviation calculated from logCFU/standard errors to-be plotted
#calculate % change from control 
murine_efflux_data <- murine_efflux_data %>% 
        mutate(PCHG = (((logCFU_mL-1.5)/logCFU_mL)*100)) #1.5 is average logCFU for control 
