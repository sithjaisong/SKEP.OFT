#####-----Step 4 Calculation for Systemic injuries
###

systemic.inj <- group_by(data.injsys, treatment, rep)

sys.inj <- summarise(systemic.inj, 
                     xBB = max(mean(BB)), 
                     xHB = max(mean(HB)),
                     xGSD = max(mean(GSD)), 
                     xRSD = max(mean(RSD)), 
                     xRTV = max(mean(YSD)))
