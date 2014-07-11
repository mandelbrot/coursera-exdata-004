#lubridate packages for functions wday and days
install.packages("lubridate")
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

png(filename="plot2.png",width = 480, height = 480)
plot(as.numeric(unlist(dat[3])),x=dat$DateTime, axes=FALSE, type = "l", 
     main = "",
     xlab="", ylab="Global Active Power (kilowatts)")
axis(side=2, at=sequence,
     labels=sequence)
axis(1, at = labDates, labels = labDatesDay)
box()
dev.off()


