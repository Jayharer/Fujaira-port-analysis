# Fujaira-port-analysis
Fujaira port of United Urab Emirates .  Analysis for anchorage time &amp; loading time for Aggregate cargo

# Common shipping terms
Berth : Specified location where loading/unloading of cargo is done.

# Data terms description
VESSEL  : Name of ship
ETA     : Estimated time of arrival
ETB     : Estimated time of berth
ETD     : Estimated time of departure
QTY     : Cargo(Commodity) quantity
SHIPPER : Company that transports(supply) goods by sea.

# project consist of three part

# Part one
Read raw dataset remove duplicate and write into new file using R.

# Part two
Datetime format in raw dataset is not in proper structure for analysis.
Convert it into proper structure datetime formate using Python.

# Part three : Analysis Dataset(Exploratory Analysis)
1. Find Pattern of anchorage time(wating time require for ship to get berth location)
2. Present it using scatter plot
3. Find pattern of loading time.
4. Find frequency of each vessel.
5. Find frequency of each shipper

# Part Four : Apply regression algorithm predict loading time based on cargo quantity

