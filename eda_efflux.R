library(tidyverse)
library(readxl)
murine_efflux_data <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/UNC PKPD/effluxtransporter/data/murine_efflux_data.xlsx", 
                                 sheet = "df", col_types = c("text", "text", 
                                                             "numeric", "numeric", "numeric", 
                                                             "numeric", "numeric"))

ggplot(data=murine_efflux_data,
       aes(x=Time_hrs,y=logCFU_mL,color=Treatment))+
        geom_point()+
        geom_smooth(se=FALSE)+
        ggtitle("Bacterial Burden over Time across all Treatments")+
        xlab("Time Sampled (hours)")+
        ylab("Log CFU/mL")+
        theme_bw()

#log transform values and take mean of each value and plot w standard error for each point 
murine_efflux_data <- murine_efflux_data %>% 
        mutate(logCFU_mL = log(CFU_mL))
#calculate mean & standard deviation
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
        geom_point()+
        geom_smooth(se=FALSE)+
        geom_errorbar(aes(ymin=avgCFU-var,ymax=avgCFU+var,width=0.2))+
        ggtitle("Bacterial Burden over Time across all Treatments")+
        scale_x_continuous(breaks=c(0,2,8,24))+
        scale_y_continuous(breaks=c(0,1,2,3),limits=c(0,3))+
        xlab("Time Sampled (hours)")+
        ylab("Log CFU/mL")+
        theme_bw()

#Percent Change (negative y-axis) 
ggplot(data=murine_efflux_data,
       aes(x=Time_hrs,y=PCHG,color=Treatment))+
        geom_point()+
        geom_smooth(se=FALSE)+
        ggtitle("Bacterial Burden over Time across Time-series Data")+
        scale_x_continuous(breaks=c(2,8,24))+
        xlab("Time Sampled (hours)")+
        ylab("% Change from Control")+
        theme_bw()+
        theme(legend.position="none")#removes legend 





