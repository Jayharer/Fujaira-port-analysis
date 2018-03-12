
#------------------------- PART3 - Exploratory Analysis  -----------------------------#

# reading fujaira Fujaira structured dataset
fdata  = read.csv("E:/Fujaira port analysis/Fujaira_structured.csv")

# get structure of data
str(fdata)

# view first few rows
head(fdata)

# observe is there any missing value in berth column
table(is.na(fdata$berth))

# yes there is missing value in bert column get index location and replace with mode of berth
berth_NA = which(is.na(fdata$berth) == T)
fdata$berth[berth_NA] = 6

# convert eta,etb, &etd into posixlt datetime format
fdata$eta = as.POSIXct(fdata$eta)
fdata$etb = as.POSIXct(fdata$etb)
fdata$etd = as.POSIXct(fdata$etd)

# table function on vessel & shipper categorical column
sort(table(fdata$vessel))
sort(table(fdata$shipper))


#--------------------      Analyse anchorage time   -----------------------#


# get anchorage(waiting) time for each ship by substracting (etb date - eta date)
anchorage_time = fdata$etb - fdata$eta

# to get anchorage time in hours
anchorage_time = anchorage_time /3600

# convert data type of anchorage_time(posixlt) into double
anchorage_time  = as.double(anchorage_time)

# view information through box plot
boxplot(anchorage_time)

# after viewing graph we observe that there is outlier present in data, replace this with median value
# get index location of outlier
outlier_index = which(anchorage_time > 200)

# replace outlier value with median value
anchorage_time[outlier_index] = median(anchorage_time)

# view information through box plot
boxplot(anchorage_time)

# convert anchorage_time in number of days
anchorage_time = anchorage_time /24

# view anchorage time
hist(anchorage_time)

# rounded anchorage time up to 2 digit
anchorage_time = round(anchorage_time,1)

# getsummary on anchorage time
summary(anchorage_time)



#------------------------    Analyze Berth Duration(Loading Time)   --------------------#



# get berthing time for each ship by substracting (etd date - etb date)
loading_time = fdata$etd - fdata$etb

# convert data type of loading_time(posixlt) into double
loading_time  = as.double(loading_time)

# convert loading time in number of days
loading_time = loading_time / 24

# rounded anchorage time up to 2 digit
loading_time = round(loading_time,2)

# view loading time
boxplot(loading_time)
hist(loading_time)

# get summary on loading lime
summary(loading_time)



#---------------------- Identify Relationship Between Cargo qty and Loading time  ----------------#


# form data frame 
df_qty_ltime = data.frame( cargo_qty = fdata$qty,
                           no_of_loading_days = loading_time,
                           berth = fdata$berth)

# view information through scatter plot
library(ggplot2)
ggplot(df_qty_ltime, aes(x = cargo_qty , y = no_of_loading_days , color = factor(berth))) +
  geom_point()

# correlation between qty and loading time(no of days)
cor.test(df_qty_ltime$cargo_qty, df_qty_ltime$no_of_loading_days)

# We observe that there is linear relationship between cargo qty and loading time
# As cargo qty increases loading time increases 



#----------- PART-4 Predict loading time(no of days) given cargo qty using Linear Regression  ------#


# form data frame of two variable cargo_qty, no_of_loading_days
qty_load_time = df_qty_ltime[ ,c(1,2)]

# divide dataset(df_qty_ltime) into train and test set
# take 80% data for training & 20 % for testing

# setting seed to reproduce results of random sampling
set.seed(100)

# row indices for training data
trainingRowIndex <- sample(1:nrow(qty_load_time), 0.8*nrow(qty_load_time))

# model training data
trainingData <- qty_load_time[trainingRowIndex, ] 

# model test data
testData  <- qty_load_time[-trainingRowIndex, ] 

# Build the model on training data
lm_Model <- lm(no_of_loading_days ~ cargo_qty, data = trainingData)  # build the model

summary(lm_model)

days_Predicted <- predict(lm_Model, testData)  # predict distance

# form data frame of actual vs predicted
actual_vs_predicted = data.frame(actual = testData$no_of_loading_days , predict = round(days_Predicted,2))

# print actual & predicted values
head(actual_vs_predicted,20)

# correlation accuracy on actual & predicted values
correlation_accuracy = cor.test(actual_vs_predicted$actual , actual_vs_predicted$predict)
print(correlation_accuracy)


#-------------------------      END   --------------------------#








