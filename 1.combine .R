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

# Select the country you are inquring
country <- "Philippines"
# country <- "Indonesia" # not available
# country <- "India" # not available
# country <- "Vietnam" # not available
# country <- "Thailand" # not available

#season <- "WS2013" # not available
season <- "DS2013"
#season <- "WS2014" # not available
#season <- "DS2014" # not available
#season <- "WS2015" # not avialble
#season <- "DS2014" # not available

#trt <- c("GM21")
#rep <- c("R1","R2", "R3", "R4")
#sheet <- c("sheet4")

ntrt <- length(trt) # number of tretment
nrep <- length(rep) # number of replication
nsheet <- length(sheet) # number of data sheet in one file
                
###-----------------------------------------------------               
 
 data.all.sheet1 <- list() # strore the data sheet1 of all file in the lists
 data.all.sheet2 <- list() # strore the data sheet2 of all file in the lists
 data.all.sheet3 <- list() # strore the data sheet3 of all file in the lists
 data.all.sheet4 <- list() # strore the data sheet4 of all file in the lists

# Import file from google drive, Pls find the data in share folder, and change the user name, foe example from iSith to your user
 for(i in 1: ntrt){        
 
         for(j in 1: nrep){ 
                
<<<<<<< HEAD
         file <- list.files(path = paste("/Users/iSith/Google Drive/SKEP2ProjectData/On Farm Trial/",
                                         country,
                                         "/",
                                         season,
                                         sep = ""),
                            pattern = "R.SKEPII.DS2013[[:graph:]]+.xlsx$",
                            full.names = TRUE)
=======
         file <- list.files(path = paste("~/Google Drive/SKEP2ProjectData/On Farm Trial/", country, "/", season, sep = ""), pattern = "R.SKEPII.DS2014[[:graph:]]+.xlsx$", full.names = TRUE)
>>>>>>> FETCH_HEAD
         
         data <- loadWorkbook(file[i]) # load excel file 
        ## one excel file composed of 4 sheets of data
        # load data sheet 1 the injuries on leave and tiller or hill, combine and merge all the data
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
                          
         # load data sheet2 the systemic injuires such as viral disease , and hopperburn caused by brown planthopper , save as list
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
         
         # load data sheet3 the weed infastration and save as list
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
         
         # load data sheet4 the yield save as list
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
 sheet1 <- do.call("rbind", data.all.sheet1) # merge the list in one 
 sheet2 <- do.call("rbind", data.all.sheet2) # merge the list in one 
 sheet3 <- do.call("rbind", data.all.sheet3) # merge the list in one 
 sheet4 <- do.call("rbind", data.all.sheet4) # merge the list in one 

#####--- Save the data for use in the next analysis
save(sheet1, sheet2, sheet3, sheet4, file = "alldata.RData")
 
# eos
