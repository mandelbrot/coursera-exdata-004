#read only 1/7/2007 and 2/7/2007
dat = read.table("C:/Users/Marko/Downloads/R/household_power_consumption_truncated.txt", 
                 sep=";",  header=TRUE)
head(dat)

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat$Date

head(dat)
summary(dat)

sequence <-seq(0,ceiling(max(dat[3])),0.5)

png(filename="plot1.png",width = 480, height = 480)
hist(as.numeric(unlist(dat[3])), col="red", breaks=sequence, axes=FALSE, 
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
axis(side=1, at=seq(0, 6, by=2))
axis(side=2, at=seq(0, 2000, by=200),
     labels=seq(0, 2000, by=200))
dev.off()