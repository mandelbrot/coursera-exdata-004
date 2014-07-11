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

sequence <- seq(0,ceiling(max(dat[3])),2)
labDates <- c(dat$DateTime[1], dat$DateTime[nrow(dat)/2+1], dat$DateTime[nrow(dat)])
labDatesDay <-labDates
labDatesDay[3] <- labDatesDay[3]+days(1)
labDatesDay <- wday(labDatesDay, label=TRUE)

sequence <- seq(0,30,10)
png(filename="plot3.png",width = 480, height = 480)
plot(dat$Sub_metering_1,x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="", ylab="Energy sub metering")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
lines(dat$Sub_metering_2,x=dat$DateTime, col="red")
lines(dat$Sub_metering_3,x=dat$DateTime, col="blue")
legend('topright', names(dat)[7:9] , 
       lty=1, col=c('black', 'red', 'blue'), border="black")
box()
dev.off()

