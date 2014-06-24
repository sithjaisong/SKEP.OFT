### Insect injuries on tiller or panicles

ins.till.inj <- group_by(insect.injuries1, treatment, rep)
ins.till <- summarise(ins.till.inj,
                      xDH = max(DH.100),
                      xRT = max(RT.100),
                      xSN = max(SN.100),
                      xRB = max(RB.100),
                      xSS = max(SS.100),
                      xWH = max(WH.100),
                      xPM = max(PM.100))

        
#### Disease on Panicle 

dis.till.inj <- group_by(disease.injuries1, treatment, rep,DVS)

dis.till <- summarise(ins.till.inj,
                      xDP = max(DP.100),
                      xFsm = max(Fsm.100),
                      xNB = max(NB.100),
                      xShB = max(ShB.100),
                      xShR = max(ShR.100))

# the output are 
# ins.till 
# dis.till 