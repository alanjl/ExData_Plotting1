
# read the data into a data frame
hpc <- read.table("../household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",
colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", 
               "numeric", "numeric", "numeric"))

# make a vector of dates 
hpcDates <- as.Date(hpc$Date, "%d/%m/%Y")
# assign the dates to the Date attribute of hpc
hpc$Date <- hpcDates

# get the subset of relevant data
relData <- hpc[as.Date(hpc$Date,"%Y-%m-%d") %in% as.Date(c("2007-02-01", "2007-02-02"),"%Y-%m-%d"),]


# prepare the plot area for the four plots
par(mfrow = c(2, 2), bg="white") 

# Graph 4, multiple graphs
# Graph 4.1 DateTime vs global active power (kilowatts)
# prepare suitable data for the date-time variable
dateTimes <- paste(relData$Date,relData$Time)
relDT <- strptime(dateTimes, "%Y-%m-%d %H:%M:%S")
plot(relDT, relData$Global_active_power, type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(relDT, relData$Global_active_power, type="l")

# 4.2 Voltage vs datetime
plot(relDT, relData$Voltage, type="n",xlab="datetime",ylab="Voltage")
lines(relDT, relData$Voltage, type="l",col=1)

# Graph 4.3 Sub-metering 1, 2, 3
plot(relDT, relData$Sub_metering_1, type="n",xlab="",ylab="Energy sub metering")
lines(relDT, relData$Sub_metering_1, type="l",col=1)
lines(relDT, relData$Sub_metering_2, type="l",col=2)
lines(relDT, relData$Sub_metering_3, type="l",col=4)
# Add the legend
legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "),lty = 1)

# 4.4 Global_reactive_power vs datetime
plot(relDT, relData$Global_reactive_power, type="l",col=1,xlab="datetime",ylab="Global_reactive_power")
#lines(relDT, relData$Global_reactive_power, type="l",col=1)

# copy to a file device
dev.copy(png,file = "plot4.png")
dev.off()



