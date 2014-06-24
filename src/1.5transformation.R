



file <- paste("R.SKEPII.",trt[1],".DS2014.SJ.xlsx", sep = "") # file Name (formatforR.xlsx)
#file2 <- paste("R.SKEPII.",trt[i],"DS2014.SJ.xlsx", sep = "") 
#file3 <- paste("R.SKEPII.",trt[i],"DS2014.SJ.xlsx", sep = "") 
#file4 <- paste("R.SKEPII.",trt[i],"DS2014.SJ.xlsx", sep = "") 
##--- Dont Change ---##
## Load work book (excel file)
data <- loadWorkbook(file)
#data2 <- loadWorkbook(file2)
#data3 <- loadWorkbook(file3)
#data4 <- loadWorkbook(file4)



data.injleave<- readWorksheet(data, 
                               sheet= "sheet1",
                               endCol= 41)





#for(i in (1: ntrt)){
#####-----Step 3 : Calculation each injury per sampling sites
## Creat new colume for No of leave per hill the calculation N of tiller x N leave per tiller

#####----- step 3.1 Insect injuries on tiller or hill
## tranform the recorded data to intensity by convert to be percent 

insect.injuries1 <- mutate(data.injleave,   
                           Nlh = Nt*Nlt,
                           DH.100 = (DH/Nt)*100, 
                           RT.100= RT/Nt*100, # Percent of Rat damage in one hill
                           SN.100= SN/Nt*100, # Percent of Snail damage in one hill
                           RB.100= RB/Nt*100, # Percent of Rice Bug injuries in one hill
                           SS.100= SS/Nt*100, # Percent of Silvershoot in one hill
                           WH.100= WH/Nt*100, # Percent of Whitehead in one hill
                           PM.100= PM/Nt*100 # Percent of Rat damage in one hill
)
#####----- step 3.2 Disease on Panicle
disease.injuries1 <-  mutate(data.injleave, 
                             Nlh = Nt*Nlt,
                             DP.100 = DP/Nt*100, # Percent of Deadheart in one hill
                             Fsm.100= Fsm/Nt*100, # Percent of Rat damage in one hill
                             NB.100= NB/Nt*100, # Percent of Snail damage in one hill
                             ShB.100= ShB/Nt*100, # Percent of Rice Bug injuries in one hill
                             ShR.100= ShR/Nt*100 # Percent of Silvershoot in one hill
)
#####----- step 3.3 Insect Injuries on leave
insect.injuries2 <- mutate(data.injleave, 
                           Nlh = Nt*Nlt,
                           LF.100 = LF/Nlh*100, # Percent of Deadheart in one hill
                           LM.100= LM/Nlh*100, # Percent of Rat damage in one hill
                           RH.100= RH/Nlh*100, # Percent of Snail damage in one hill
                           WM.100= WM/Nlh*100, # Percent of Rice Bug injuries in one hill
                           Defo.100= Defo/Nlh*100, # Percent of Defo in one hill
                           Thrip.100= Thrip/Nlh*100 # Percent of thrip in one hill 
)
#####----- step 3.4 Disease on leave
disease.injuries2 <- mutate(data.injleave, 
                            Nlh = Nt*Nlt,
                            BLB.100= BLB/Nlh*100, # Percent of Bacterial leaf Blight in one hill
                            BLS.100= BLS/Nlh*100, # Percent of Bacterial leaf streak in one hill
                            BS.100= BS/Nlh*100, # Percent of Brown Spot in one hill
                            LB.100= LB/Nlh*100, # Percent of leaf Blight in one hill
                            LS.100= LS/Nlh*100, # Percent of leaf scald in one hill
                            NBS.100= NBS/Nlh*100, # Percent of Narrow brown spot in one hill
                            RS.100= RS/Nlh*100, # Percent of Red stripe in one hill
)
#####-----Step 5 Calcuation for Weed

data.injweed[,10:11][data.injweed[,10:11] =="0"] <- 0
data.injweed[,10:11][data.injweed[,10:11] =="1"] <- 5
data.injweed[,10:11][data.injweed[,10:11] =="2"] <- 20
data.injweed[,10:11][data.injweed[,10:11] =="3"] <- 45
data.injweed[,10:11][data.injweed[,10:11] =="4"] <- 80

###
injweed <- group_by(data.injweed, Treatment ,visit)


injweed1 <- summarise(injweed,
                      m.WA = mean(WA),
                      m.WB = mean(WB),
                      m.BLW = mean(BLW),
                      m.G = mean(G),
                      m.S = mean(S),
                      m.SW = mean(SW))

### Yield
yield <- group_by(data.yield, treatment)

sum.yield <- summarise(yield, m.Y = Y/MC*14)

### The output
#injweed1
#
#
