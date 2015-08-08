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


## Create the graphs ##
## Set png device
png("plot4.png", width = 480, height = 480, units = "px")

## Check the value of par ("mfrow)
par("mfcol")
## Store the original value that will be used later on
mymfcol <- par("mfcol")
## Set the figure layout
par(mfcol = c(2,2))

## Plot the first graph on position 1,1
## xaxt = "n" supress the plotting of axis x. Axis x will be
## plotted by axis function right after plot.
plot(hPowerConsumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", col = "black", xaxt = "n")
axis(1, at = c(0,1440, 2880), labels = c("Thu", "Fri", "Sat"))

## Plot the second graph on position 2,1
## xaxt = "n" supress the plotting of axis x. Axis x will be
## plotted by axis function right after plot.
plot(hPowerConsumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black", xaxt = "n")
## Add the second line
lines(hPowerConsumption$Sub_metering_2, col = "red")
lines(hPowerConsumption$Sub_metering_3, col = "blue")
axis(1, at = c(0,1440, 2880), labels = c("Thu", "Fri", "Sat"))
## legend, bty = "n" to remove the box line.
legend("topright", cex = 0.8, lty = 1, bty = "n", col = c("black", "red", "blue"), legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot the third graph on position 1,2
## xaxt = "n" supress the plotting of axis x. Axis x will be
## plotted by axis function right after plot.
plot(hPowerConsumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", col = "black", xaxt = "n")
axis(1, at = c(0,1440, 2880), labels = c("Thu", "Fri", "Sat"))

## Plot the fourth graph on position 2,2
## xaxt = "n" supress the plotting of axis x. Axis x will be
## plotted by axis function right after plot.
plot(hPowerConsumption$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", col = "black", xaxt = "n")
axis(1, at = c(0,1440, 2880), labels = c("Thu", "Fri", "Sat"))


## Close the png device
dev.off()

## Restore the original value
Sys.setlocale("LC_TIME", lct)

## Restore the original value of par
par(mfcol = mymfcol)