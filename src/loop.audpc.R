trt <- c("FP", "PR", "RP", "GM21", "GM22")
rep <- c("R1", "R2", "R3", "R4")
ntrt <- length(trt)
nrep <- length(rep)
for(i in (1: ntrt)){ for ( j in (1:nrep)){
        
        #####-----Step 2 : Load data
        file1 <- paste("R.SKEPII.",trt[i],".",rep[j],".DS2014.SJ.xlsx", sep = "") # file Name (formatforR.xlsx)
        #file2 <- paste("R.SKEPII.",trt[i],rep[j],".DS2014.SJ.xlsx", sep = "") 
        #file3 <- paste("R.SKEPII.",trt[i],rep[j],".DS2014.SJ.xlsx", sep = "") 
        #file4 <- paste("R.SKEPII.",trt[i],rep[j],".DS2014.SJ.xlsx", sep = "") 

        ##--- Dont Change ---##
        ## Load work book (excel file)
        data1 <- loadWorkbook(file1)
        #data2 <- loadWorkbook(file2)
        #data3 <- loadWorkbook(file3)
        #data4 <- loadWorkbook(file4)
        
        # the funcyions of readWorksheet -> return to data.frame
        #data.injleave <- readWorksheet(data, sheet= "sheet1",startRow=  2,endRow= 1 ,startCol= 1,endCol= 1) 
        
        
        #data.prodsit <- readWorksheet(data, 
        #                              sheet= "sheet1",
        #                              startRow=  2,
        #                              endCol= 17,)
        #data.prodsit[ is.na(data.prodsit) ] <- 0
        #head(data.prodsit)
        
        # dataset1 is the data collected 12 sampling site such as 
        # insect or disease injuries on leave, tiller or panicle
        
        #Load spicific injuries
        data.sheet1<- readWorksheet(data1, 
                                       sheet= "sheet1",
                                       startRow=  2,
                                       endCol= 41)
        data.sheet1[is.na(data.sheet1)] <- 0 # fill the empty block with 0
        
        percent.injleave <- mutate(data.sheet1,   
                                   Nlh = Nt*Nlt,
                                   DH.100 = (DH/Nt)*100, 
                                   RT.100= RT/Nt*100, # Percent of Rat damage in one hill
                                   SN.100= SN/Nt*100, # Percent of Snail damage in one hill
                                   RB.100= RB/Nt*100, # Percent of Rice Bug injuries in one hill
                                   SS.100= SS/Nt*100, # Percent of Silvershoot in one hill
                                   WH.100= WH/Nt*100, # Percent of Whitehead in one hill
                                   PM.100= PM/Nt*100, # Percent of Rat damage in one hill
                                   LF.100 = LF/Nlh*100, # Percent of Deadheart in one hill
                                   LM.100= LM/Nlh*100, # Percent of Rat damage in one hill
                                   RH.100= RH/Nlh*100, # Percent of Snail damage in one hill
                                   WM.100= WM/Nlh*100, # Percent of Rice Bug injuries in one hill
                                   Defo.100= Defo/Nlh*100, # Percent of Defo in one hill
                                   Thrip.100= Thrip/Nlh*100, # Percent of thrip in one hill
                                   BLB.100= BLB/Nlh*100, # Percent of Bacterial leaf Blight in one hill
                                   BLS.100= BLS/Nlh*100, # Percent of Bacterial leaf streak in one hill
                                   BS.100= BS/Nlh*100, # Percent of Brown Spot in one hill
                                   LB.100= LB/Nlh*100, # Percent of leaf Blight in one hill
                                   LS.100= LS/Nlh*100, # Percent of leaf scald in one hill
                                   NBS.100= NBS/Nlh*100, # Percent of Narrow brown spot in one hill
                                   RS.100= RS/Nlh*100, # Percenent of Red stripe
                                   DP.100 = DP/Nt*100, # Percent of Deadheart in one hill
                                   FSm.100= FSm/Nt*100, # Percent of Rat damage in one hill
                                   NB.100= NB/Nt*100, # Percent of Snail damage in one hill
                                   ShB.100= ShB/Nt*100, # Percent of Rice Bug injuries in one hill
                                   ShR.100= ShR/Nt*100 # Percent of Silvershoot in one hill
        )
        
        per.leave.inj <- group_by(percent.injleave, treatment, rep,DVS)
        
        leave.inj <- summarise(per.leave.inj,
                               XDH = mean(DH.100), 
                               xRT= mean(RT.100), # Mean of percent of rat damge in rep
                               xSN= mean(SN.100), # Mean of percent of rat damge in dam
                               xRB= mean(RB.100), # Mean of percent of rat damge in rep
                               xSS= mean(SS.100), # Mean of percent of rat damge in rep
                               xWH= mean(WH.100), # Mean of percent of rat damge in rep
                               xPM= mean(PM.100), # Mean of percent of rat damge in rep
                               xLF= mean(LF.100), # Mean of percent of rat damge in rep
                               xLM= mean(LM.100), # Mean of percent of rat damge in rep
                               xRH= mean(RH.100), # Mean of percent of rat damge in rep
                               xWM= mean(WM.100), # Mean of percent of rat damge in rep
                               xDefo= mean(Defo.100), # Mean of perceinill
                               xThrip= mean(Thrip.100), # Mean of perin one hill
                               xBLB= mean(BLB.100), # Mean of percent in one hill
                               xBLS= mean(BLS.100), # Mean of percentin one hill
                               xBS= mean(BS.100), # Mean of percent o Spot in one hill
                               xLB= mean(LB.100), # Mean of percent o in one hill
                               xLS= mean(LS.100), # Mean of percent o scald in one hill
                               xNBS= mean(NBS.100), # Mean of percentown spot in one hill
                               xRS= mean(RS.100), # Mean of percent o Red stripe
                               xDP= mean(DP.100), # Mean of percent on repn one hill
                               xFSm= mean(FSm.100), # Mean of percentn rone hill
                               xNB= mean(NB.100), # Mean of percent on rephill
                               xShB= mean(ShB.100), # Mean of percent of ratll
                               xShR= mean(ShR.100) # 
        )
        
        leave.inj <- group_by(leave.inj, treatment, rep)
        
        
        ### AUDPC # the functions from the agricolae is bugs for this format
        
        AUDPC.ins.leave <- summarise(leave.inj,
                                     AUDPC.LF = audpc(leave.inj$xLF,leave.inj$DVS),
                                     AUDPC.LM = audpc(leave.inj$xLM,leave.inj$DVS),
                                     AUDPC.RH = audpc(leave.inj$xRH,leave.inj$DVS),
                                     AUDPC.WM = audpc(leave.inj$xWM,leave.inj$DVS),
                                     AUDPC.Defo = audpc(leave.inj$xDefo,leave.inj$DVS),
                                     AUDPC.BLB = audpc(leave.inj$xBLB, leave.inj$DVS),
                                     AUDPC.BLS = audpc(leave.inj$xBLS, leave.inj$DVS),
                                     AUDPC.LB = audpc(leave.inj$xLB, leave.inj$DVS),
                                     AUDPC.LS = audpc(leave.inj$xLS, leave.inj$DVS),
                                     AUDPC.NBS = audpc(leave.inj$xNBS, leave.inj$DVS),
                                     AUDPC.RS = audpc(leave.inj$xRS, leave.inj$DVS))
        
        output.trt <- data.frame()
        output.trt<- rbind(output.trt, AUDPC.ins.leave)
        

#wb <- loadWorkbook(paste("R.audpc.SKEPII.",trt[i],".",rep[j],".byrep.DS2014.SJ.xlsx", sep = ""), create = TRUE)
#createSheet(wb, name = "sheet1")


#writeWorksheet(wb, AUDPC.ins.leave, sheet = "sheet1")
#saveWorkbook(wb)
}
write.table(output.trt, file = paste("R.audpc.SKEPII.",trt[i],".DS2014.SJ.xlsx", sep = ""), create = TRUE),write)
}        
  