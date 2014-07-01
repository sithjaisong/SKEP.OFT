###' Titile  :          The script for computation of onfarm trial data 
###'                    of SKEP project
###' Designed By        Sith Jaisong
###'                    Plant Disease Management team
###'                    CESD, IRRI           
###' Purpose            combine data from excel file to csv file
###' Input file         data frame named
###'                    sheet1 : leave and tiller injuires 
###'                    sheet2 : systemic injuries
###'                    sheet3 : weed infastration
###'                    sheet4 : yield 
###' Output             data frame named total
###'                    alldata.RData
###'                    CSV file and R.SKEP.DS2014.OFT.csv 
###'                    sheet 1 is data of production situation and
###' Date of modified   1 July 2014

##### Define output name

output.name <- " R.DS2014.OFT.csv"

##### Load data
lnames <- load(file = "alldata.RData")


######----- Water status transformation from scale to percent 
if(sheet1$WS == 1 & sheet1$DVS == "100"){ 
        sheet1$WSC <- 0
} else {
        if(sheet1$WS == 2 & sheet1$DVS == "100"){
                sheet1$WSC <- 0       
        } else {
                if(sheet1$WS == 3 & sheet1$DVS == c("70", "80" ,"90", "100")){
                        sheet1$WSC <- 0
                } else {
                        if(sheet1$WS == 4 & sheet1$DVS == "100"){
                                sheet1$WSC <- 0
                        } else {
                                if(sheet1$WS == 5 & sheet1$DVS == c("70", "80" ,"90", "100")){
                                        sheet1$WSC <- 0
                                } else { 
                                        if(sheet1$WS == 6 & sheet1$DVS =="100"){
                                                sheet1$WSC <- 0
                                        } else {
                                                if( sheet1$WS == 7){
                                                        sheet1$WSC <- 0 
                                                } else {
                                                        if(sheet1$WS == 8 & sheet1$DVS == c("70", "80" ,"90", "100")){
                                                                sheet1$WSC <- 0
                                                        } else {
                                                                if (sheet1$WS == 8 & sheet1$DVS == c( "10", "20", "30", "40", "50", "60")){
                                                                        sheet1$WSC <- 1
                                                                } else {
                                                                        if (sheet1$WS == 9){
                                                                                sheet1$WSC <- 0
                                                                        } else {
                                                                                if (sheet1$WS == 10){
                                                                                        sheet1$WSC <- 1
                                                                                } else {
                                                                                        if( sheet1$WS == 11 & sheet1$DVS == c("30", "40", "50", "60")){
                                                                                                sheet1$WSC <- 0
                                                                                        } else { 
                                                                                                if( sheet1$WS == 11 & sheet1$DVS == c("10", "20", "70", "80", "90", "100")){
                                                                                                        sheet1$WSC <- 1
                                                                                                } else { sheet1$WSC <- -1}
                                                                                        }}}}}}}}}}}}


######----- Analysis sheet 1 leave and tiller injuries-----######
sheet1 <- mutate(sheet1,   
                         Nlh = Nt*Nlt,
                         # tiller injuries
                         DH.100 = (DH/Nt)*100, 
                         RT.100= RT/Nt*100, # Percent of Rat damage in one hill
                         SN.100= SN/Nt*100, # Percent of Snail damage in one hill
                         RB.100= RB/Nt*100, # Percent of Rice Bug injuries in one hill
                         SS.100= SS/Nt*100, # Percent of Silvershoot in one hill
                         WH.100= WH/Nt*100, # Percent of Whitehead in one hill
                         PM.100= PM/Nt*100, # Percent of panicle mite in one hill
                         DP.100 = DP/Nt*100, # Percent of Dirty Panicle in one hill
                         FSm.100= FSm/Nt*100, # Percent of False smut in one hill
                         NB.100= NB/Nt*100, # Percent of Neck Blast in one hill
                         ShB.100= ShB/Nt*100, # Percent of Shealth Blight injuries in one hill
                         ShR.100= ShR/Nt*100, # Percent of Shealth Rot in one hill
                         # leave injuries
                         LF.100 = LF/Nlh*100, # Percent of Leaffolder in one hill
                         LM.100= LM/Nlh*100, # Percent of Leaf miner in one hill
                         RH.100= RH/Nlh*100, # Percent of Rice hispa in one hill
                         WM.100= WM/Nlh*100, # Percent of Whorl maggot injuries in one hill
                         Defo.100= Defo/Nlh*100, # Percent of Defoliator in one hill
                         Thrip.100= Thrip/Nlh*100, # Percent of Thrip in one hill
                         BLB.100= BLB/Nlh*100, # Percent of Bacterial leaf Blight in one hill
                         BLS.100= BLS/Nlh*100, # Percent of Bacterial leaf streak in one hill
                         BS.100= BS/Nlh*100, # Percent of Brown Spot in one hill
                         LB.100= LB/Nlh*100, # Percent of leaf Blight in one hill
                         LS.100= LS/Nlh*100, # Percent of leaf scald in one hill
                         NBS.100= NBS/Nlh*100, # Percent of Narrow brown spot in one hill
                         RS.100= RS/Nlh*100 # Percent of Red stripe in one hill
)

sheet1 <- group_by(sheet1,season, year ,treatment, rep, DVS)

## compute mean from 12 samplings
com.sheet1 <- summarise(sheet1,
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

com.sheet1 <- group_by(com.sheet1,season, year, treatment, rep)

output.sheet1 <- summarise(com.sheet1,
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


######----- Analysis sheet 2 systemic injuies-----######
# select the maximum percent of mean along the time of experiment

sheet2 <- group_by(sheet2, season, year ,treatment, rep)

output.sheet2 <- summarise(sheet2, 
                     xBB = max(mean(BB)), 
                     xHB = max(mean(HB)),
                     xGSD = max(mean(GSD)), 
                     xRSD = max(mean(RSD)), 
                     xRTV = max(mean(YSD)))


#####----- Analysis sheet 3 weed infastration-----#####
#Calcuation for Weed sheet3, especially WA and WB
# tranform from scale to percent
sheet3[,10:11][sheet3[,10:11] =="0"] <- 0
sheet3[,10:11][sheet3[,10:11] =="1"] <- 5
sheet3[,10:11][sheet3[,10:11] =="2"] <- 20
sheet3[,10:11][sheet3[,10:11] =="3"] <- 45
sheet3[,10:11][sheet3[,10:11] =="4"] <- 80

###
sheet3 <- group_by(sheet3, season, year ,treatment, rep, DVS)

# find mean 
sheet3 <- mutate(sheet3,
                      m.WA = mean(WA),
                      m.WB = mean(WB),
                      m.BLW = mean(BLW),
                      m.G = mean(G),
                      m.S = mean(S),
                      m.SW = mean(SW))

com.sheet3 <- group_by(sheet3,season, year, treatment, rep)

output.sheet3 <- summarise(com.sheet3, 
                            x.WA = audpc(m.WA, DVS),
                            x.WB = audpc(m.WB, DVS)
                            )
#####----- Analysis sheet 4 Yield Evalustion-----#####

sheet4 <- mutate(sheet4, m.Y = (Y/MC)*14, yield.kg.ha = m.Y*2000)

sheet4 <- group_by(sheet4,season, year, treatment, rep)

output.sheet4 <- summarise(sheet4, ykh.m = mean(ykh))


### The combine output
output.list <- list(output.sheet1, output.sheet2, output.sheet3 , output.sheet4)
summary.data <- merge_recurse(output.list)
write.csv(summary.data, file = output.name)


