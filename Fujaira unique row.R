
# read data transform it into unique rows
# and write into new file


# reading fujaira raw dataset
fdata_raw = read.csv("E:/Fujaira port analysis/Fujaira_raw_dataset.csv")

# check dimension befor removing duplicate
dim(fdata)

# convert all upper column names into lower case
name_vector = names(fdata_raw)
names(fdata_raw) = tolower(name_vector)

# remove duplicate rows from dataset
fdata = unique(fdata_raw)

# get dimension after removing duplicate
dim(fdata)

# writing into csv file
write.csv(fdata, file = "E:/Fujaira port analysis/Fujaira_unique.csv", row.names = F)

