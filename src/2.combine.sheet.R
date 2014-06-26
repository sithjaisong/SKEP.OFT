#trt <- c( "FP", "GM21")
#ntrt <- length(trt)
sheet <- c("sheet1","sheet2", "sheet3", "sheet4")
nsheet <- length(sheet)

for(i in (1: nsheet)){ 
        
        #####-----Step 2 : Load data
        name.file1 <- paste("R.SKEPII.","FP",".DS2014.SJ.",sheet[i],".csv", sep = "") # file Name (formatforR.xlsx)
        name.file2 <- paste("R.SKEPII.","PR",".DS2014.SJ.",sheet[i], ".csv",sep = "")
        name.file3 <- paste("R.SKEPII.","RP",".DS2014.SJ.",sheet[i], ".csv",sep = "")
        name.file4 <- paste("R.SKEPII.","GM21",".DS2014.SJ.",sheet[i],".csv", sep = "")
        name.file5 <- paste("R.SKEPII.","GM22",".DS2014.SJ.",sheet[i],".csv", sep = "")
        
        file1 <- read.csv(name.file1)
        file2 <- read.csv(name.file2)
        file3 <- read.csv(name.file3)
        file4 <- read.csv(name.file4)
        file5 <- read.csv(name.file5)
        
        output <- rbind(file1, file2, file3, file4, file5)
        
        name.output <- paste("R.SKEPII.DS2014.SJ.",sheet[i],".csv",sep="")
        
        write.csv(output, file = name.output)
}
       
        
        
        