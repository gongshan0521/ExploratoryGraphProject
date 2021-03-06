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


## plot1, histogram of global acitve power
png("plot1.png", width = 480, height = 480)
hist(plotdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()