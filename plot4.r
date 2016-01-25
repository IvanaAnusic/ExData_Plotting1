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

dateTime <- paste(data$Date, as.character(data$Time))
dateTime <- strptime(dateTime, format="%Y-%m-%d %T")


names(data)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
nrow(data)

sub2 <- which(data$Sub_metering_2 < 10)
sub3 <- which(data$Sub_metering_3 > 0)


data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_active_power <- data$Global_active_power/500


data$Voltage <- as.numeric(data$Voltage)



png(paste(path, "plot4.png", sep=""), width=480, height=480, units="px")
par(mfrow=c(2,2))
plot(x=dateTime, y=data$Global_active_power, 
     xlab="", ylab="Global Active Power (kilowatts)", main="", type="l")
plot(x=dateTime, y=data$Voltage, 
     xlab="datetime", ylab="Voltage", main="", type="l")
plot(x=dateTime, y=data$Sub_metering_1, type="l", col="black")
lines(x=dateTime, y=data$Sub_metering_2, col="red")
lines(x=dateTime, y=data$Sub_metering_3, col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
plot(x=dateTime, y=data$Global_reactive_power, 
     xlab="datetime", ylab="Voltage", main="", type="l")
dev.off()
