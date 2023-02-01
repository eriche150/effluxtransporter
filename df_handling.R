#Load in necessary packages 
library(tidyverse)

#Load in dataset from iOS
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
#plot mean for each time point with standard errors
ggplot(data=murine_efflux_data,
       aes(x=Time_hrs,y=avgCFU,color=Treatment))+
        geom_point(size=2)+
        geom_line()+
        geom_errorbar(aes(ymin=avgCFU-var,ymax=avgCFU+var,width=0.2))+
        ggtitle("Bacterial Burden over Time across all Treatments")+
        scale_x_continuous(breaks=c(-8,0,2,8,24))+
        scale_y_continuous(breaks=c(0,1,2,3),limits=c(0,3))+
        xlab("Time Sampled (hours)")+
        ylab("Log CFU/mL")+
        theme_bw()
#Percent Change (negative y-axis) 
ggplot(data=murine_efflux_data,
       aes(x=Time_hrs,y=PCHG,color=Treatment))+
        geom_point()+
        geom_line()+
        ggtitle("% Change from Baseline for Bacterial Burden over Time across all Treatments")+
        scale_x_continuous(breaks=c(2,8,24))+
        xlab("Time Sampled (hours)")+
        ylab("% Change from Control")+
        theme_bw()+
        theme(legend.position="none")#removes legend 
