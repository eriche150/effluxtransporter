timeseriesdf<-murine_efflux_data %>% 
        filter(Treatment == "Colistin_Monotherapy"|Treatment == "Combination_PBT2_Colistin"|
                       Treatment=="Meropenem_Monotherapy"|Treatment =="Combination_PBT2_Meropenem")
ggplot(data=timeseriesdf,
       aes(x=Time_hrs,y=avgCFU,color=Treatment))+
        geom_point()+
        geom_smooth(se=FALSE)+
        geom_errorbar(aes(ymin=avgCFU-var,ymax=avgCFU+var,width=0.2))+
        geom_hline(yintercept = 1.5, linetype="dashed", color="lightgreen")+
        ggtitle("Bacterial Burden over Time across Time-series Data")+
        scale_x_continuous(breaks=c(0,2,8,24))+
        scale_y_continuous(breaks=c(0,1,2,3),limits=c(0,3))+
        xlab("Time Sampled (hours)")+
        ylab("Log CFU/mL")+
        theme_bw()

#Percent Change (negative y-axis) 
ggplot(data=timeseriesdf,
       aes(x=Time_hrs,y=PCHG,color=Treatment))+
        geom_point()+
        geom_smooth(se=FALSE)+
        ggtitle("Bacterial Burden over Time across Time-series Data")+
        scale_x_continuous(breaks=c(2,8,24))+
        xlab("Time Sampled (hours)")+
        ylab("% Change from Control")+
        theme_bw()+
        theme(legend.position="none")#removes legend 
