# read the data into a data frame
hpc <- read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",
colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", 
               "numeric", "numeric", "numeric"))

# make a vector of dates 
hpcDates <- as.Date(hpc$Date, "%d/%m/%Y")
# assign the dates to the Date attribute of hpc
hpc$Date <- hpcDates

# get the subset of relevant data
relData <- hpc[as.Date(hpc$Date,"%Y-%m-%d") %in% as.Date(c("2007-02-01", "2007-02-02"),"%Y-%m-%d"),]

# Graph 2 DateTime vs global active power (kilowatts)
# prepare suitable data for the date-time variable
dateTimes <- paste(relData$Date,relData$Time)
relDT <- strptime(dateTimes, "%Y-%m-%d %H:%M:%S")

par(bg="white")
plot(relDT, relData$Global_active_power, type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(relDT, relData$Global_active_power, type="l")

# copy to a file device, note that the default size is 480 x 480 pixels
dev.copy(png, file = "plot2.png")
dev.off()
