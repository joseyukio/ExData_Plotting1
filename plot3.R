## Load the libraries
library(dplyr)
library(data.table)
library(lubridate)

## Check the LC_TIME value
Sys.getlocale("LC_TIME")
## Store the original value that will be used later on
lct <- Sys.getlocale("LC_TIME")
## Set the locale to C. This will output the date/time information in English.
Sys.setlocale("LC_TIME", "C")

## The code assume the file is stored in folder "/CourseProject1"
## Read the file
hPowerConsumption <- read.csv("CourseProject1/household_power_consumption.txt", sep = ";",na.strings = "?")

## Convert the column "Date" to Date class
hPowerConsumption$Date <- dmy(hPowerConsumption$Date)

## Not all rows are needed.
## Filter the rows per date. The comparison must be done between the same classes
## So the value to be compared must be converted to Date class.
hPowerConsumption <- filter(hPowerConsumption, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

## Create the graph
## Set png device
png("plot3.png", width = 480, height = 480, units = "px")

## Plot the graph.
## xaxt = "n" supress the plotting of axis x. Axis x will be
## plotted by axis function right after plot.
plot(hPowerConsumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black", xaxt = "n")
## Add the second line
lines(hPowerConsumption$Sub_metering_2, col = "red")
lines(hPowerConsumption$Sub_metering_3, col = "blue")
axis(1, at = c(0,1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", cex = 0.8, lty = 1, col = c("black", "red", "blue"), legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the png device
dev.off()

## Restore the original value
Sys.setlocale("LC_TIME", lct)
