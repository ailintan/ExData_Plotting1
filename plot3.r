# read household_power_consumption.txt excluding missing values
pwr <- read.table("household_power_consumption.txt", header= TRUE, sep=";", na.strings="?")
tmp <- pwr
pwr <- tmp
#convert date to Date class
pwr$Date <- as.Date(pwr$Date,"%d/%m/%Y")

#Select only data from 2007-02-01 to 2007-02-02
pwr <- subset(pwr, Date >= "2007-02-01" & Date <= "2007-02-02");

#Convert the Date and Time variables to Date/Time classes 
dateTime <- paste(pwr$Date, pwr$Time)
dateTime <- as.POSIXct(dateTime)
pwr <- cbind(dateTime, pwr)

#plot the chart
y <- plot(pwr$Sub_metering_1~pwr$dateTime, type="l", ylab="Energy sub metering", xlab="")
lines(pwr$Sub_metering_2~pwr$dateTime, col= "red")
lines(pwr$Sub_metering_3~pwr$dateTime, col= "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty="solid")

#library(ggplot2)
#library(scales)
#plot the chart
#y <- ggplot()+
#   geom_line(data=pwr, aes(x=dateTime, y = Sub_metering_2), colour= "red")+
#  geom_line(data=pwr, aes(x=dateTime, y = Sub_metering_3), colour= "blue")+
#   geom_line(data=pwr, aes(x=dateTime, y = Sub_metering_1)) +
#   ylab("Energy sub metering") +
#   xlab("") +
#   scale_x_date(breaks = date_breaks("1 day"), labels=date_format("%a"))

## Save file and close device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
