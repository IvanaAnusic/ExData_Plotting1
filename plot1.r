path <- "C:/Assignment 1/"

data <- read.table(paste(path, "household_power_consumption.txt", sep=""), sep=";", header=T)
data[1:5,]
names(data)

data$Date <- as.Date(strptime(as.character(data$Date), format="%d/%m/%Y"))


data$Date[1:10] < as.Date(strptime("2007-02-01", format="%Y-%m-%d"))

toKeep <- (data$Date == as.Date(strptime("2007-02-01", format="%Y-%m-%d"))) | (data$Date == as.Date(strptime("2007-02-02", format="%Y-%m-%d")))
table(toKeep)
data <- data[toKeep,]
nrow(data)

table(data$Global_active_power)
data$Global_active_power <- as.numeric(data$Global_active_power)

png(paste(path, "plot1.png", sep=""), width=480, height=480, units="px")
hist(data$Global_active_power/500, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", axes=F)
axis(1)
axis(2, at=seq(0, 1200, 200), labels=c("0", "200", "400", "600", "800", "1000", "1200"))
dev.off()
