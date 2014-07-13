
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

# make a histogram with red bars, set the x-label and the main title.
# Graph 1 histogram

par(bg="white")
hist(relData$Global_active_power, col=c("red"),main="Global Active Power", xlab="Global Active Power (kilowatts)")


# copy to a file device
dev.copy(png, file = "plot1.png")
dev.off()
