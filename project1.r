setwd("/Users/Tenorio/vermonster/exercises/")
mydata <- read.table("power.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)

# select only data from 1/2/2007 and 2/2/2007
day1 <- subset(mydata, grepl("^1/2/2007", mydata$Date))
day2 <- subset(mydata, grepl("^2/2/2007", mydata$Date))
bothdays <- rbind(day1,day2)

# format date and time
dates <- as.Date(bothdays$Date, format="%d/%m/%Y")
times <- bothdays$Time
datetime <- paste(dates,times)
data <- cbind(datetime, bothdays)

# create plot1
png("plot1.png", width = 480, height = 480)
active_power <- c(as.numeric(data$Global_active_power))
hist(active_power, col="red", xlim=c(0,6), ylim=c(0,1200), main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=c(0,2,4,6), labels=c(0,2,4,6))


# create plot2
png("plot2.png", width = 480, height = 480)
plot(active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))


# create plot3
png("plot3.png", width = 480, height = 480)
sub1 <- c(as.numeric(data$Sub_metering_1))
sub2 <- c(as.numeric(data$Sub_metering_2))
sub3 <- c(as.numeric(data$Sub_metering_3))
plot(sub1, type="l", ylab="Energy sub metering", xlab="",xaxt="n")
axis(1, at=c(1, (length(active_power)/2), length(active_power)), labels=c("Thu","Fri","Sat"))
lines(sub2, col="red")
lines(sub3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.8, col=c("black","red","blue"), lty=1)

reactive_power <- c(data$Global_reactive_power)
plot(reactive_power, type="l", xlab="", ylab="Global_reactive_power", xaxt="n", yaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,45,90,135,180,225), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))

voltage <- c(data$Voltage)
plot(voltage, type="l", xlab="", xaxt="n", yaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))
axis(2, at=c(800,1200,1600,2000), labels=c("234","238","242","246"))

