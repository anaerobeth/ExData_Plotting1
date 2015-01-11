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
datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
data <- cbind(datetime, bothdays)

# create plot3
png("plot3.png", width = 480, height = 480)
sub1 <- c(as.numeric(data$Sub_metering_1))
sub2 <- c(as.numeric(data$Sub_metering_2))
sub3 <- c(as.numeric(data$Sub_metering_3))
plot(datetime, sub1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, sub2, col="red")
lines(datetime, sub3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.8, col=c("black","red","blue"), lty=1)

dev.off()

