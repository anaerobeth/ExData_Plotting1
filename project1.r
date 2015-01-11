etwd("/Users/Tenorio/vermonster/exercises/")
mydata <- read.table("power.txt", sep=";", header=TRUE)

# select only data from 1/2/2007 and 2/2/2007
day1 <- subset(mydata, grepl("^1/2/2007", mydata$Date))
day2 <- subset(mydata, grepl("^2/2/2007", mydata$Date))
bothdays <- rbind(day1,day2)

# format date and time
dates <- as.Date(bothdays$Date)
times <- bothdays$Time
datetime <- paste(dates,times)
data <- cbind(datetime, bothdays)

# convert Global_active_power to kilowatts
data$GAP_in_kw <- as.numeric(data$Global_active_power) / 1000.0

# create plot1
active_power <- c(data$GAP_in_kw)
hist(active_power, col="red", xlim=c(0,6), ylim=c(0,1200), main="Global Active Power", xlab="Global Active Power (kilowatts)")
png("plot1.png")

plot(active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n", yaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,1,2,3), labels=c("0","2","4","6"))
png("plot2.png")

sub1 <- c(as.numeric(data$Sub_metering_1))
sub2 <- c(as.numeric(data$Sub_metering_2))
sub3 <- c(as.numeric(data$Sub_metering_3))
plot(sub1, type="l")
lines(sub2)
lines(sub3)

reactive_power <- c(data$Global_reactive_power)
plot(reactive_power, type="l", xlab="", ylab="Global_reactive_power", xaxt="n", yaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,45,90,135,180,225), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))

voltage <- c(data$Voltage)
plot(voltage, type="l", xlab="", xaxt="n", yaxt="n")
axis(1, at=c(1, 1500, length(active_power)), labels=c("Thu","Fri","Sat"))
axis(2, at=c(800,1200,1600,2000), labels=c("234","238","242","246"))

