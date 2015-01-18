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

hist(data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     ylim =c(0,1200))

dev.copy(png, "plot1.png")
dev.off()
