#AUDPC for Leave injuries

ins.leave.inj <- group_by(insect.injuries2, treatment, rep,DVS)


ins.leave.inj <- summarise(ins.leave.inj,
                m.LF = mean(LF.100),
                m.LM = mean(LM.100),
                m.RH = mean(RH.100),
                m.WM = mean(WM.100),
                m.Defo = mean(Defo.100))

### AUDPC # the functions from the agricolae is bugs for this format

AUDPC.ins.leave <- summarise(ins.leave.inj,
                         AUDPC.LF = audpc(ins.leave.inj$m.LF,ins.leave.inj$DVS),
                         AUDPC.LM = audpc(ins.leave.inj$m.LM,ins.leave.inj$DVS),
                         AUDPC.RH = audpc(ins.leave.inj$m.RH,ins.leave.inj$DVS),
                         AUDPC.WM = audpc(ins.leave.inj1$m.WM,ins.leave.inj$DVS),
                         AUDPC.Defo = audpc(ins.leave.inj$m.Defo,ins.leave.inj$DVS))


#AUDPC for disease on leave

dis.leave.inj <- group_by(disease.injuries2, treatment, rep,DVS)

dis.leave.inj <- summarise(dis.leave.inj,
                           m.BLB = mean(BLB.100),
                           m.BLS = mean(BLS.100),
                           m.LB = mean(LB.100),
                           m.LS = mean(LS.100),
                           m.NBS = mean(NBS.100),
                           m.RS = mean(RS.100))

### AUDPC # the functions from the agricolae is bugs for this format

AUDPC.dis.leave <- summarise(dis.leave.inj,
                             AUDPC.BLB = audpc(dis.leave.inj$m.BLB, dis.leave.inj$DVS),
                             AUDPC.BLS = audpc(dis.leave.inj$m.BLS, dis.leave.inj$DVS),
                             AUDPC.LB = audpc(dis.leave.inj$m.LB, dis.leave.inj$DVS),
                             AUDPC.LS = audpc(dis.leave.inj$m.LS, dis.leave.inj$DVS),
                             AUDPC.NBS = audpc(dis.leave.inj$m.NBS, dis.leave.inj$DVS),
                             AUDPC.RS = audpc(dis.leave.inj$m.RS, dis.leave.inj$DVS))
## The output 
# AUDPC.ins.leave
# AUDPC.dis.;eave