## Read the data
fileName <- "household_power_consumption.txt"
rawdata <- read.table(fileName, header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".")

## Construct Data and Time
timeData <- paste(rawdata[, 1], rawdata[, 2])
timeData <- strptime(timeData, "%d/%m/%Y %H:%M:%S")

## Select only the data with in data range 2017-02-01 to 2017-02-02
timeIndex <- timeData >= "2007-02-01" & timeData < "2007-02-03"
plotdata <- cbind(data.frame(DateTime = timeData[timeIndex]), rawdata[timeIndex, 3:9])
## Remove NA values
plotdata <- plotdata[!is.na(plotdata$DateTime), ]
for (i in 2:8) {
  plotdata[, i] <- as.numeric(plotdata[, i])
}


## plot4, 
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
plot(plotdata$DateTime, plotdata$Global_active_power, type="l", xaxt="n", xlab = "",  ylab = "Global Active Power")
axis.POSIXct(1, at=seq(min(plotdata$DateTime), max(plotdata$DateTime), by="days"), format = "%a")
plot(plotdata$DateTime, plotdata$Voltage, type="l", xaxt="n", xlab = "datetime",  ylab = "Voltage")
axis.POSIXct(1, at=seq(min(plotdata$DateTime), max(plotdata$DateTime), by="days"), format = "%a")
plot(plotdata$DateTime, plotdata$Sub_metering_1, type="l", xaxt="n", xlab = "",  ylab = "Energy sub metering")
axis.POSIXct(1, at=seq(min(plotdata$DateTime), max(plotdata$DateTime), by="days"), format = "%a")
lines(plotdata$DateTime, plotdata$Sub_metering_2, col = "Red")
lines(plotdata$DateTime, plotdata$Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(plotdata$DateTime, plotdata$Global_reactive_power, type="l", xaxt="n", xlab = "datetime",  ylab = "Global_reactive_power")
axis.POSIXct(1, at=seq(min(plotdata$DateTime), max(plotdata$DateTime), by="days"), format = "%a")
dev.off()