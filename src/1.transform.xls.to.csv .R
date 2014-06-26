
library(XLConnect)
library(dplyr) # Data manipulation
source("function.audpc.R")

### Loading special funtions 
trt <- c("FP", "PR", "RP", "GM21", "GM22")
ntrt <- length(trt)
for(i in (1: ntrt)){ 
        
        #####-----Step 2 : Load data
        file1 <- paste("R.SKEPII.",trt[i],".R1.","DS2014.SJ.xlsx", sep = "") # file Name (formatforR.xlsx)
        file2 <- paste("R.SKEPII.",trt[i],".R2.","DS2014.SJ.xlsx", sep = "") 
        file3 <- paste("R.SKEPII.",trt[i],".R3.","DS2014.SJ.xlsx", sep = "") 
        file4 <- paste("R.SKEPII.",trt[i],".R4.","DS2014.SJ.xlsx", sep = "") 
        ##--- Dont Change ---##
        ## Load work book (excel file)
        data1 <- loadWorkbook(file1)
        data2 <- loadWorkbook(file2)
        data3 <- loadWorkbook(file3)
        data4 <- loadWorkbook(file4)
        
        #Load spicific injuries
        data.injleave1<- readWorksheet(data1, 
                                       sheet= "sheet1",
                                       startRow=  2,
                                       endCol= 41)
        data.injleave1[is.na(data.injleave1)] <- 0 # fill the empty block with 0
        
        data.injleave2<- readWorksheet(data2, 
                                       sheet= "sheet1",
                                       startRow=  2,
                                       endCol= 41)
        data.injleave2[is.na(data.injleave2)] <- 0 # fill the empty block with 0
        
        data.injleave3<- readWorksheet(data3, 
                                       sheet= "sheet1",
                                       startRow=  2,
                                       endCol= 41)
        data.injleave3[is.na(data.injleave3)] <- 0 # fill the empty block with 0
        
        data.injleave4<- readWorksheet(data4, 
                                       sheet= "sheet1",
                                       startRow=  2,
                                       endCol= 41)
        data.injleave4[is.na(data.injleave4)] <- 0 # fill the empty block with 0
        
        
        injleave.total <- rbind(data.injleave1, data.injleave2, data.injleave3, data.injleave4)
        
        output <- paste("R.SKEPII.",trt[i],".DS2014.SJ.","sheet1",".csv", sep = "")
        write.csv( injleave.total, file = output)
        
        ##### Load systemic injuries : sheet 2
        
        data.injsys1<- readWorksheet(data1, 
                                     sheet= "sheet2",
                                     startRow=  2)
        
        data.injsys1[is.na(data.injsys1)] <- 0 # fill the empty block with 0
        
        data.injsys2<- readWorksheet(data2, 
                                     sheet= "sheet2",
                                     startRow=  2)
        
        data.injsys2[is.na(data.injsys2)] <- 0 # fill the empty block with 0
        
        data.injsys3<- readWorksheet(data3, 
                                     sheet= "sheet2",
                                     startRow=  2)
        
        data.injsys3[is.na(data.injsys3)] <- 0 # fill the empty block with 0
        
        data.injsys4<- readWorksheet(data4, 
                                     sheet= "sheet2",
                                     startRow=  2)
        
        data.injsys4[is.na(data.injsys4)] <- 0 # fill the empty block with 0
        
        injsys.total <- rbind(data.injsys1,data.injsys2, data.injsys3,data.injsys4)
        
        output <- paste("R.SKEPII.",trt[i],".DS2014.SJ.","sheet2",".csv", sep = "")
        
        write.csv( injsys.total, file = output)
        
        ##### ----- Load weed profile
        
        data.injweed1<- readWorksheet(data1, 
                                      sheet= "sheet3",
                                      startRow=  2)
        
        data.injweed1[is.na(data.injweed1)] <- 0
        
        data.injweed2<- readWorksheet(data2, 
                                      sheet= "sheet3",
                                      startRow=  2)
        
        data.injweed2[is.na(data.injweed2)] <- 0
        
        data.injweed3<- readWorksheet(data3, 
                                      sheet= "sheet3",
                                      startRow=  2)
        
        data.injweed3[is.na(data.injweed3)] <- 0
        
        data.injweed4<- readWorksheet(data4, 
                                      sheet= "sheet3",
                                      startRow=  2)
        
        data.injweed4[is.na(data.injweed4)] <- 0
        
        injweed.total <- rbind(data.injweed1, data.injweed2, data.injweed3, data.injweed4)
        
        output <- paste("R.SKEPII.",trt[i],".DS2014.SJ.","sheet3",".csv", sep = "")
        
        write.csv( injweed.total, file = output)
        
        ##### Load Yield data
        
        data.yield1<- readWorksheet(data1, 
                                    sheet= "sheet4",
                                    startRow= 2)
        data.yield2<- readWorksheet(data2, 
                                    sheet= "sheet4",
                                    startRow= 2)
        data.yield3<- readWorksheet(data3, 
                                    sheet= "sheet4",
                                    startRow= 2)
        data.yield4<- readWorksheet(data4, 
                                    sheet= "sheet4",
                                    startRow= 2)
        
        yield.total <- paste("yield.total.",trt[1], sep = "")
        
        yield.total <- rbind(data.yield1, data.yield2, data.yield3, data.yield4)
        
        output.sheet4 <- paste("R.SKEPII.",trt[i],".DS2014.SJ.","sheet4",".csv", sep = "")
        
        write.csv( yield.total, file = output.sheet4)
        
}