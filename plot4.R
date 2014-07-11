#lubridate packages for functions wday and days
#install.packages("lubridate")
library(lubridate)

#read only 1/7/2007 and 2/7/2007
dat = read.table("C:/Users/Marko/Downloads/R/household_power_consumption_truncated.txt", 
                 sep=";",  header=TRUE)
head(dat)
summary(dat)

#cleaning trailing spaces
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
#new column for date and time
dat$DateTime <- trim(paste(dat$Date,dat$Time))#, format="%Y-%m-%d %h:%m:%s")
dat$DateTime <- as.POSIXct(strptime(trim(paste(dat$Date,dat$Time)), "%Y-%m-%d %H:%M:%S"))
head(dat$DateTime)
summary(dat$DateTime)
summary(dat$Voltage)

sequence <- seq(0,ceiling(max(dat[3])),2)
labDates <- c(dat$DateTime[1], dat$DateTime[nrow(dat)/2+1], dat$DateTime[nrow(dat)])
labDatesDay <-labDates
labDatesDay[3] <- labDatesDay[3]+days(1)
labDatesDay <- wday(labDatesDay, label=TRUE)

png(filename="plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
#plot1
labDates <- c(dat$DateTime[1], dat$DateTime[nrow(dat)/2+1], dat$DateTime[nrow(dat)])
labDatesDay <-labDates
labDatesDay[3] <- labDatesDay[3]+days(1)
labDatesDay <- wday(labDatesDay, label=TRUE)

plot(as.numeric(unlist(dat[3])),x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="", ylab="Global Active Power")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
box()

#plot2
sequence <- seq(floor(min(dat$Voltage)) - 1, ceiling(max(dat$Voltage)), 2)
plot(dat$Voltage,x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="datetime", ylab="Voltage")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
box()

#plot3
sequence <- seq(0,30,10)
plot(dat$Sub_metering_1,x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="", ylab="Energy sub metering")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
lines(dat$Sub_metering_2,x=dat$DateTime, col="red")
lines(dat$Sub_metering_3,x=dat$DateTime, col="blue")
box()
legend('topright', names(dat)[7:9], bty='n', cex=.9, 
       lty=1, col=c('black', 'red', 'blue'))

#plot4
sequence <- seq(0.0, max(dat$Global_reactive_power), 0.1)
plot(dat$Global_reactive_power,x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="datetime", ylab="Global_reactive_power")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
box()

dev.off()
