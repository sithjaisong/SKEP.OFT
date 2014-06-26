data.sheet1 <- read.csv("R.SKEPII.DS2014.SJ.sheet1.csv")
data.sheet2 <- read.csv("R.SKEPII.DS2014.SJ.sheet2.csv")
data.sheet3 <- read.csv("R.SKEPII.DS2014.SJ.sheet3.csv")
data.sheet4 <- read.csv("R.SKEPII.DS2014.SJ.sheet4.csv")

inj.sheet1.transform <- mutate(data.sheet1,   
                               Nlh = Nt*Nlt,
                               # tiller injuries
                               DH.100 = (DH/Nt)*100, 
                               RT.100= RT/Nt*100, # Percent of Rat damage in one hill
                               SN.100= SN/Nt*100, # Percent of Snail damage in one hill
                               RB.100= RB/Nt*100, # Percent of Rice Bug injuries in one hill
                               SS.100= SS/Nt*100, # Percent of Silvershoot in one hill
                               WH.100= WH/Nt*100, # Percent of Whitehead in one hill
                               PM.100= PM/Nt*100, # Percent of Rat damage in one hill
                               DP.100 = DP/Nt*100, # Percent of Deadheart in one hill
                               FSm.100= FSm/Nt*100, # Percent of Rat damage in one hill
                               NB.100= NB/Nt*100, # Percent of Snail damage in one hill
                               ShB.100= ShB/Nt*100, # Percent of Rice Bug injuries in one hill
                               ShR.100= ShR/Nt*100, # Percent of Silvershoot in one hill
                               # leave injuries
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
                               RS.100= RS/Nlh*100 # Percent of Red stripe in one hill
)

ins.leave.inj <- group_by(inj.sheet1.transform, treatment, rep, DVS)

ins.leave.inj <- summarise(ins.leave.inj,
                           m.LF = mean(LF.100),
                           m.LM = mean(LM.100),
                           m.RH = mean(RH.100),
                           m.WM = mean(WM.100),
                           m.Defo = mean(Defo.100),
                           m.BLB = mean(BLB.100),
                           m.BLS = mean(BLS.100),
                           m.LB = mean(LB.100),
                           m.LS = mean(LS.100),
                           m.NBS = mean(NBS.100),
                           m.RS = mean(RS.100)
)


### AUDPC # the functions from the agricolae is bugs for this format
ins.leave.inj <- group_by(ins.leave.inj, treatment, rep)
#ins.leave.inj <- filter(ins.leave.inj, treatment == "FP"| rep == 1)

leave.inj <- summarise(ins.leave.inj,
                       AUDPC.LF = audpc(m.LF, DVS),
                       AUDPC.LM = audpc(m.LM, DVS),
                       AUDPC.RH = audpc(m.RH, DVS),
                       AUDPC.WM = audpc(m.WM, DVS),
                       AUDPC.Defo = audpc(m.Defo, DVS),
                       AUDPC.BLB = audpc(m.BLB, DVS),
                       AUDPC.BLS = audpc(m.BLS, DVS),
                       AUDPC.LB = audpc(m.LB, DVS),
                       AUDPC.LS = audpc(m.LS, DVS),
                       AUDPC.NBS = audpc(m.NBS, DVS),
                       AUDPC.RS = audpc(m.RS, DVS)
)


#####----- Analysis sheet 2

data.sheet2 <- read.csv("R.SKEPII.DS2014.SJ.sheet2.csv")


systemic.inj <- group_by(data.sheet2, treatment, rep)

sys.inj <- summarise(systemic.inj, 
                     xBB = max(mean(BB)), 
                     xHB = max(mean(HB)),
                     xGSD = max(mean(GSD)), 
                     xRSD = max(mean(RSD)), 
                     xRTV = max(mean(YSD)))


#####----- Analysis sheet 3
#####-----Step 5 Calcuation for Weed sheet3 

data <- read.csv("R.SKEPII.DS2014.SJ.sheet3.csv")

data[,10:11][data[,10:11] =="0"] <- 0
data[,10:11][data[,10:11] =="1"] <- 5
data[,10:11][data[,10:11] =="2"] <- 20
data[,10:11][data[,10:11] =="3"] <- 45
data[,10:11][data[,10:11] =="4"] <- 80

###
injweed <- group_by(data, treatment ,rep)


injweed <- summarise(injweed,
                      m.WA = mean(WA),
                      m.WB = mean(WB),
                      m.BLW = mean(BLW),
                      m.G = mean(G),
                      m.S = mean(S),
                      m.SW = mean(SW))

##### Analysis sheet 4 Yield
data.sheet4 <- read.csv("R.SKEPII.DS2014.SJ.sheet4.csv")

yield <- mutate(data.sheet4, m.Y = (Y/MC)*14, ykh = m.Y*2000)

yield <- group_by(yield, treatment, rep)

sum.yield <- summarise(yield, ykh.m = mean(ykh))

### The output

total1 <- merge(leave.inj, sys.inj, by = c("treatment","rep"))
total2 <- merge(injweed , sum.yield, by = c("treatment","rep"))
total <- merge(total1 , total2, by = c("treatment","rep"))
