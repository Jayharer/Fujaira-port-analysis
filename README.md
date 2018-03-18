# Fujaira-port-analysis
Fujaira port of United Urab Emirates .  Analysis for anchorage time &amp; loading time for Aggregate cargo. There is one sample copy of 
daily port line up FUJAIRAH PORT LINE UP (005) (1).xls.

# Common shipping terms
Berth : Specified location where loading/unloading of cargo is done.

# Data terms description
VESSEL  : Name of ship
ETA     : Estimated time of arrival
ETB     : Estimated time of berth
ETD     : Estimated time of departure
QTY     : Cargo(Commodity) quantity
SHIPPER : Company that transports(supply) goods by sea.

# project consist of four part

# Part one
Read raw dataset (Fujaira_raw_dataset.csv) remove duplicate and write into new file using R(Fujaira unique row.R).

# Part two
Datetime format in raw dataset is not in proper structure for analysis.
Convert it into proper structured datetime formate using Python (Fujaira_port_2.py).

# Part three : Analysis Dataset(Exploratory Analysis)
1. Find Pattern of anchorage time(wating time require for ship to get berth location)
2. Present it using scatter plot
3. Find pattern of loading time.
4. Find frequency of each vessel.
5. Find frequency of each shipper
(Fujaira port.R)

# Part Four : Apply regression algorithm predict loading time based on cargo quantity
(Fujaira port.R)

