## load lubridate for date formatting
library(lubridate)

## load  dplyr for filter()
library(dplyr)

## read data
file <- "data/household_power_consumption.txt"
edata <- read.table(file, sep=";", header=T, na.strings="?")

##  use lubridate to parse date & time to POSIX
edata$Date <- dmy(edata$Date)
edata$Time <- hms(edata$Time)

## add column for date-time
edata$DateTime <- edata$Date + edata$Time

##  subset data
edata <- filter(edata, year(Date) == 2007 & month(Date) == 02 & (day(Date) == 1 | day(Date) == 2))

##  initialize png for plotting
png(filename="plot4.png", width = 480,height = 480, units = "px" )

## create plot in 2 by 2 matrix
par(mfrow = c(2,2))
plot(edata$DateTime, edata$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

plot(edata$DateTime, edata$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

plot(edata$DateTime, edata$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(edata$DateTime, edata$Sub_metering_2, type = "l", col = "red")
points(edata$DateTime, edata$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty="n", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(edata$DateTime, edata$Global_reactive_power, type="l", 
     xlab="datetime", ylab = "Global_reactive_power")

## close graphics device
dev.off()