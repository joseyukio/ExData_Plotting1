## Load the libraries
library(dplyr)
library(data.table)
library(lubridate)

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
png("plot1.png", width = 480, height = 480, units = "px")

## Plot the histogram
hist(hPowerConsumption$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Close the png device
dev.off()
