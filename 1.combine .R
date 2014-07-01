##############################################################################
# titile        : 1.combine.R;
# purpose       : combine data from excel file to csv file;
# producer      : Sith Jaisong and A. H. Sparks;
#                 Plant Disease Management team
#                 CESD, IRRI;
# last update   : In Los Baños, 1 Jul. 2014;
# inputs        : Microsoft Excel file in each replication and treatment;
# outputs       : data frame named sheet1, sheet2, sheet3 and sheet4
# remarks 1     : sheet 1 is data of production situation and leaf and tiller injuries
#                 sheet 2 is the systemic injuries
#                 sheet 3 is the seed infestation
#                 sheet 4 is the yield samples;;
# Licence:      : GPL2;
##############################################################################

#### Begin load libraries ####
library(XLConnect)
library(dplyr)
library(reshape)
library(reshape2)
#### End load libraries ####

#### Load functions ####
source("Functions/function.audpc.R")
#### End load functions #####

#### Specify variables, the treatment, replication and name of sheets we have ####
trt <- c("FP", "PR", "RP", "GM21","GM22") # treatements
rep <- c("R1", "R2", "R3", "R4") # replications
sheet <- c("sheet1", "sheet2", "sheet3", "sheet4") # Excel Sheet

country <- "Philippines"
# country <- "Indonesia"
# country <- "India"
# country <- "Vietnam"
# country <- "Thailand"

#season <- "WS2013"
season <- "DS2013"

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
                
         file <- list.files(path = paste("/Users/asparks/Google Drive/SKEP2ProjectData/On Farm Trial/", country, "/", season, sep = ""), pattern = "R.SKEPII.DS2014[[:graph:]]+.xlsx$", full.names = TRUE)
         
         data <- loadWorkbook(file[i])
         # sheet1
         data.sheet1 <- readWorksheet(data, sheet = sheet[1], startRow = 2, endCol = 41)
        
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
         data.sheet2<- readWorksheet(data, sheet = sheet[2],
                                      startRow =  2)
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
 sheet1 <- do.call("rbind", data.all.sheet1)
 sheet2 <- do.call("rbind", data.all.sheet2)
 sheet3 <- do.call("rbind", data.all.sheet3)
 sheet4 <- do.call("rbind", data.all.sheet4)

#####--- Save the data for use in the next analysis
save(sheet1, sheet2, sheet3, sheet4, file = "alldata.RData")
 
# eos
