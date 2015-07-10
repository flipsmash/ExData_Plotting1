#load library lubridate for easy date parsing
library(lubridate)

#load  dplyr for filter()
library(dplyr)

file <- "data/household_power_consumption.txt"
edata <- read.table(file, sep=";", header=T, na.strings="?")

##  use lubridate to parse date & time to POSIX
edata$Date <- dmy(edata$Date)
edata$Time <- hms(edata$Time)

## add date plus time col
edata$DateTime <- edata$Date + edata$Time

##  subset data
edata <- filter(edata, year(Date) == 2007 & month(Date) == 02 & (day(Date) == 1 | day(Date) == 2))

##  initialize png for plotting
png(filename="plot1.png", width = 480,height = 480, units = "px" )

## create plot
hist(edata$Global_active_power, main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")

## close graphics device
dev.off()