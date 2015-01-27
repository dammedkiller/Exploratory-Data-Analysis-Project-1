library(data.table)
library(lubridate)
library(ggplot2)

##Read dataset
data = data.table(read.table("household_power_consumption.txt", 
                             header=TRUE, 
                             na.strings=c("?", "NA"), 
                             sep=";",
                             colClasses=c(rep("factor",2), rep("numeric", 7))
))

##Convert Date from factor to date variable and subset just the rows corresponding to the period between 
##2007-02-01 and 2007-02-02
data$Date = data[, dmy(Date)]
data = data[ymd("2007-02-01") <= Date & Date <= ymd("2007-02-02"), ]

##Create date variable with the Date and Time variables (pasted) of the dataset
date = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

##Plot the data
plot(date, data$Global_active_power, "l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

##Save the plot in a png image
dev.copy(png, "plot2.png")
dev.off()
