

trt <- c("FP", "PR", "RP", "GM21", "GM22")
ntrt <- length(trt)

for(i in (1: ntrt)){

file <- paste("R.SKEPII.",trt[i],".DS2014.SJ.xlsx", sep = "") # file Name (formatforR.xlsx)

##--- Dont Change ---##
## Load work book (excel file)
data <- loadWorkbook(file)




data.sheet1 <- readWorksheet(data, 
                              sheet= "sheet1",
                              endCol= 41)

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

per.leave.inj <- group_by(percent.injleave, treatment, rep)

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
                     xShR= mean(ShR.100) # M
)



################

data.sheet2<- readWorksheet(data, 
                             sheet= "sheet2")

systemic.inj <- group_by(data.sheet2, treatment, rep)

sys.inj <- summarise(systemic.inj, 
                     xBB = max(mean(BB)), 
                     xHB = max(mean(HB)),
                     xGSD = max(mean(GSD)), 
                     xRSD = max(mean(RSD)), 
                     xRTV = max(mean(YSD)))


###############
data.sheet3<- readWorksheet(data, 
                            sheet= "sheet3",
                            endCol= 11)

data.sheet3[,10:11][data.sheet3[,10:11] =="0"] <- 0
data.sheet3[,10:11][data.sheet3[,10:11] =="1"] <- 5
data.sheet3[,10:11][data.sheet3[,10:11] =="2"] <- 20
data.sheet3[,10:11][data.sheet3[,10:11] =="3"] <- 45
data.sheet3[,10:11][data.sheet3[,10:11] =="4"] <- 80

###
injweed <- group_by(data.sheet3, treatment ,visit)


weed.inj <- summarise(injweed,
                      m.WA = mean(WA),
                      m.WB = mean(WB)
                      )

### Yield
data.sheet4 <- readWorksheet(data, 
                             sheet= "sheet4")

yield <- group_by(data.sheet4, treatment, rep)

sum.yield <- summarise(yield, 
                       Yield = (mean(Y)/mean(MC))*14)

bytreatment <- data.frame()
bytreatment <- cbind(leave.inj, 
                     sys.inj[,3:7], 
                     weed.inj[,3:4],
                     sum.yield[3])

bytreatment[i] <- rbind(bytreatment[ntrt],bytreatment[ntrt-1])
#wb <- loadWorkbook(paste("R.SKEPII.",trt[i],".byrep.DS2014.SJ.xlsx", sep = ""), create = TRUE)
#createSheet(wb, name = "sheet1")


#writeWorksheet(wb, bytreatment, sheet = "sheet1")

#saveWorkbook(wb)
}


