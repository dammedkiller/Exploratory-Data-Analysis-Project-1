library(data.table)
library(lubridate)
library(ggplot2)

data = data.table(read.table("household_power_consumption.txt", 
                             header=TRUE, 
                             na.strings=c("?", "NA"), 
                             sep=";",
                             colClasses=c(rep("factor",2), rep("numeric", 7))
))

data$Date = data[, dmy(Date)]

data = data[ymd("2007-02-01") <= Date & Date <= ymd("2007-02-02"), ]

time = strptime(data$Time, "%H:%M:%S")

date = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

plot(date, data$Global_active_power, "l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.copy(png, "plot2.png")
dev.off()
