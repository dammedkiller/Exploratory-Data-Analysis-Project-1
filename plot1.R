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

##Plot the histogram
hist(data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     ylim =c(0,1200))

##Save the plot in a png image
dev.copy(png, "plot1.png")
dev.off()
