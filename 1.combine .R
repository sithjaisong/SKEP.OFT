###' Titile  :          The script for combine onfarm trial data 
###'                    of SKEP project
###' Designed By        Sith Jaisong
###'                    Plant Disease Management team
###'                    CESD, IRRI           
###' Purpose            combine data from excel file to csv file
###' Input file         exel file in each replication and treamrnt
###' Output             data frame named sheet1, sheet2, sheet3 and sheet4
###'                    sheet 1 is data of production situation and
###'                               leave and tiller injuies
###'                    sheet 2 is the systemic injuries
###'                    sheet 3 is the seed infestration
###'                    sheet 4 is the yield samples
###' Date of modified   30 June 2014

## load library 
library(XLConnect)
library(dplyr)
library(reshape)
library(reshape2)
source("function.audpc.R")

### Specify the the treatment , replication and name of sheets we have

trt <- c("FP", "PR", "RP", "GM21","GM22")
rep <- c("R1", "R2", "R3", "R4")
sheet <- c("sheet1", "sheet2", "sheet3", "sheet4")

#trt <- c("GM21")
#rep <- c("R1","R2", "R3", "R4")
#sheet <- c("sheet4")

ntrt <- length(trt)
nrep <- length(rep)
nsheet <- length(sheet)
                
###-----------------------------------------------------               
 
 data.all.sheet1 <- list()
 data.all.sheet2 <- list()
 data.all.sheet3 <- list()
 data.all.sheet4 <- list()

 for(i in 1: ntrt){        
 
         for(j in 1: nrep){ 
                
         file <- paste("R.SKEPII.DS2014.",trt[i],".",rep[j],".xlsx", sep = "")  
         
         data <- loadWorkbook(file)
         # sheet1
         data.sheet1<- readWorksheet(data,                                                                                            
                                     sheet= sheet[1],
                                     startRow=  2,
                                     endCol= 41)
        
         data.sheet1[is.na(data.sheet1)] <- 0                            
         if( i == 1 )
         data.all.sheet1[[j]] <- data.sheet1 
         if( i == 2 )
                 data.all.sheet1[[4+j]] <- data.sheet1 
         if( i == 3 )
                 data.all.sheet1[[8+j]] <- data.sheet1
         if( i == 4 )
                 data.all.sheet1[[12+j]] <- data.sheet1
         if( i == 5 )
                 data.all.sheet1[[16+j]] <- data.sheet1
                          
         # sheet2
         data.sheet2<- readWorksheet(data, 
                                      sheet= sheet[2],
                                      startRow=  2)
         data.sheet2[is.na(data.sheet2)] <- 0                            
         if( i == 1 )
                 data.all.sheet2[[j]] <- data.sheet2 
         if( i == 2 )
                 data.all.sheet2[[4+j]] <- data.sheet2 
         if( i == 3 )
                 data.all.sheet2[[8+j]] <- data.sheet2
         if( i == 4 )
                 data.all.sheet2[[12+j]] <- data.sheet2
         if( i == 5 )
                 data.all.sheet2[[16+j]] <- data.sheet2 
         
         # sheet3
         data.sheet3<- readWorksheet(data, 
                                     sheet= sheet[3],
                                     startRow=  2)
         data.sheet3[is.na(data.sheet3)] <- 0                            
         if( i == 1 )
                 data.all.sheet3[[j]] <- data.sheet3 
         if( i == 2 )
                 data.all.sheet3[[4+j]] <- data.sheet3 
         if( i == 3 )
                 data.all.sheet3[[8+j]] <- data.sheet3
         if( i == 4 )
                 data.all.sheet3[[12+j]] <- data.sheet3
         if( i == 5 )
                 data.all.sheet3[[16+j]] <- data.sheet3
         
         # sheet4
         data.sheet4<- readWorksheet(data, 
                                     sheet= sheet[4],
                                     startRow=  2)
         data.sheet4[is.na(data.sheet4)] <- 0                            
         if( i == 1 )
                 data.all.sheet4[[j]] <- data.sheet4 
         if( i == 2 )
                 data.all.sheet4[[4+j]] <- data.sheet4 
         if( i == 3 )
                 data.all.sheet4[[8+j]] <- data.sheet4
         if( i == 4 )
                 data.all.sheet4[[12+j]] <- data.sheet4
         if( i == 5 )
                 data.all.sheet4[[16+j]] <- data.sheet4
         }   
 }
#####---- Combine all data by sheet
 sheet1 <- do.call("rbind",data.all.sheet1)
 sheet2 <- do.call("rbind",data.all.sheet2)
 sheet3 <- do.call("rbind",data.all.sheet3)
 sheet4 <- do.call("rbind",data.all.sheet4)

#####--- Save the data for use in the next analysis
save(sheet1, sheet2, sheet3, sheet4, file = "alldata.RData")
 
# eos     