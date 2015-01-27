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

par(mfrow = c(2, 2)) ##2x2 plots
##Plot (1,1)
plot(date, data$Global_active_power, "l",
        ylab="Global Active Power (kilowatts)",
        xlab="")

##Plot (1,2)       
plot(date, data$Voltage, "l",
        ylab="Voltage",
        xlab="datetime")

##Plot(2,1)
plot(x=date, y=data$Sub_metering_1, "l",
     ylab="Energy sub-metering",
     xlab="")
lines(x=date, y=data$Sub_metering_2, "l",
      col="red")
lines(x=date, y=data$Sub_metering_3, "l",
      col="blue")
legend("topright",c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5), col=c("black","red", "blue"), bty="n", # gives the legend lines the correct color and width
       cex=0.2, y.intersp=0.05 ) 

##Plot(2,2)
plot(date, data$Global_reactive_power, "l",
     xlab="datetime")

dev.copy(png, "plot4.png")
dev.off()

