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

# create plot2
png("plot2.png", width = 480, height = 480)
plot(datetime, active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()

