## Read in data
data <- read.table("./Data/household_power_consumption.txt", sep = ";", 
                   header = TRUE, na.strings = "?")

## Converts dates to "Date" class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Subset data to get desired dates
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create new column containing both dates & times
data$DateTime <- paste(data$Date, data$Time, sep = " ")

## Convert contents of column to "POSIXct" format. 
data$DateTime <- strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")

## Create plot file
png(filename = "Plot2.png", width = 480, height = 480, units = "px")

## Create plot
with(data, plot(DateTime, Global_active_power, type = "l", xlab = "",
                ylab = "Global Active Power (kilowatts)"))

dev.off()