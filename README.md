SKEP.OFT
========

On-Farm Trial project Phase II

There are two main steps to analyse the data from SKEP on-farm trial Experiment
The raw data will be entried in exel file sepreated by four sheet named sheet1, sheet2, sheet3 and sheet4.
On-farm trial data are collected by using Survey Portfolio designed by IRRI Pest Manangement group.

Data are catagiorized in 4 Groups 

#### Leave injuries and Tiller injuries including the production situation (sheet1)
season | day | month | year | DVS | Sample | Nt |Np | Nlt| DH |SN |  
-------|-----|-------|------|-----|--------|----|---|----|----|---|
   1   |  1  | 2014  |  20  |20   |   1    | 17 | 0 | 3  | 2  |4  |

#### Systemic injuries (sheet2)
season | day | month | year | DVS |  BB | HB | GSD |RSD | RTD| TSD |  
-------|-----|-------|------|-----|-----|----|-----|----|----|-----|
   1   |  1  | 2014  |  20  |20   |10   |1   |  17 | 0  | 3  |  2  |

#### Weed infastration (sheet3)
season | day | month | year | DVS | rep  | WA | WB|  
-------|-----|-------|------|-----|------|----|---|
   1   |  1  | 2014  |  20  |20   | 1    |10  |10 |
   
#### Yield (sheet4)
season | day | month | year | DVS | rep | Sample| Y  | MC| 
-------|-----|-------|------|-----|-----|-------|--- |---|
   1   |  1  | 2014  |  20  |20   | 1   |  A    |234 |14 |
   
###Here are the steps to follow the analysis

* Step 1 Read Data in Excel file, combine and save the output ( with combine.r)

* Step 2 Analysis data following each catagorized data (with analysi.r)

