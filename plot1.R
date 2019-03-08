# #Set working directory to folder where the run_analysis.r lies
# curr_dir <- dirname(parent.frame(2)$ofile)
# setwd(curr_dir)

#library("lubridate")
library(chron)

setwd("D:/4_1_Project")
data<-read.csv("household_power_consumption.txt", header=FALSE, sep=";", skip=66637,  nrows=2880, na.strings="?",
               col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

data$Date<-as.Date(data$Date, format="%d/%m/%Y")
#data$Time<-hms(data$Time)
#data$Time<-strptime(data$Time, "%H:%M:%S")
data$Time<-times(data$Time)

png("plot1.png", width=480, height=480)
with(data, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))
dev.off()
