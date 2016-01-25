path <- "C:/Assignment 1/"

data <- read.table(paste(path, "household_power_consumption.txt", sep=""), sep=";", header=T)
data[1:5,]
names(data)

data$Date <- as.Date(strptime(as.character(data$Date), format="%d/%m/%Y"))
toKeep <- (data$Date == as.Date(strptime("2007-02-01", format="%Y-%m-%d"))) | (data$Date == as.Date(strptime("2007-02-02", format="%Y-%m-%d")))
table(toKeep)
data <- data[toKeep,]
nrow(data)
data$Date
data$weekday <- weekdays(data$Date)
table(data$Global_active_power)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_active_power <- data$Global_active_power/500

table(data$weekday)

dateTime <- paste(data$Date, as.character(data$Time))
dateTime <- strptime(dateTime, format="%Y-%m-%d %T")

png(paste(path, "plot2.png", sep=""), width=480, height=480, units="px")
plot(x=dateTime, y=data$Global_active_power, 
     xlab="", ylab="Global Active Power (kilowatts)", main="", type="l")
dev.off()
