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
png(filename = "Plot4.png", width = 480, height = 480, units = "px")

## Create plot layout for plots
par(mfrow = c(2,2))

## Create plots
with(data, {
  ##Upper left hand
  plot(DateTime, Global_active_power, type = "l", xlab = "", 
       ylab = "Global Active Power")
  ## Upper right hand
  plot(DateTime, Voltage, type = "l", xlab= "datetime", ylab = "Voltage")
 
  ## Lower left hand
  plot(DateTime, Sub_metering_1, type = "l", xlab = "", 
        ylab = "Energy sub metering")
  lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
  lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("black", "red", "blue"), bty = "n")
  ## Lower right hand
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime",
       ylab = "Global_reactive_power")
})

dev.off()