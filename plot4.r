# #Set working directory to folder where the run_analysis.r lies
# curr_dir <- dirname(parent.frame(2)$ofile)
# setwd(curr_dir)

#Set locale
Sys.setlocale("LC_TIME", "English")

library(dplyr)
library(lubridate)

setwd("D:/4_1_Project")
data<-read.csv("household_power_consumption.txt", header=FALSE, sep=";", skip=66637,  nrows=2881, na.strings="?",
               col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Convert dates
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data<-mutate(data, date_time=ymd_hms(paste(data$Date, data$Time)))

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

##Graph 1
with(data, plot(date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power", col="black", xaxt="n"))

#Draw axis
ticks<-seq(min(data$date_time), max(data$date_time), "days")
axis.POSIXct(side=1, at=ticks, format="%a")

##Graph 2
with(data, plot(date_time, Voltage, type="l", xlab="datetime", ylab="Voltage", col="black", xaxt="n"))

#Draw axis
ticks<-seq(min(data$date_time), max(data$date_time), "days")
axis.POSIXct(side=1, at=ticks, format="%a")

##Graph 3
with(data, plot(date_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black", xaxt="n"))
with(data, lines(date_time, Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red", xaxt="n"))
with(data, lines(date_time, Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue", xaxt="n"))

#Draw axis
ticks<-seq(min(data$date_time), max(data$date_time), "days")
axis.POSIXct(side=1, at=ticks, format="%a")

#Legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

##Graph 4
with(data, plot(date_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", col="black", xaxt="n"))

#Draw axis
ticks<-seq(min(data$date_time), max(data$date_time), "days")
axis.POSIXct(side=1, at=ticks, format="%a")

#Alternative: Full weekday names
#axis(1, at=ticks, weekdays(ticks))

dev.off()
