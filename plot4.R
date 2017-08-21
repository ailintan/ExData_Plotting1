# read household_power_consumption.txt excluding missing values
pwr <- read.table("household_power_consumption.txt", header= TRUE, sep=";", na.strings="?")

#convert date to Date class
pwr$Date <- as.Date(pwr$Date,"%d/%m/%Y")

#Select only data from 2007-02-01 to 2007-02-02
pwrSubset <- subset(pwr, Date >= "2007-02-01" & Date <= "2007-02-02");

#Convert the Date and Time variables to Date/Time classes 
dateTime <- paste(pwrSubset$Date, pwrSubset$Time)
dateTime <- as.POSIXct(dateTime)
pwrSubset <- cbind(dateTime, pwrSubset)

#plot for 2 by 2 chart
par(mfrow=c(2,2))

#1st chart Global Active Power
plot(pwr$Global_active_power~pwr$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#2nd chart Voltage
plot(pwrSubset$Voltage~pwrSubset$dateTime, type="l", ylab="Voltage", xlab="datetime")

#3rd chart Eneryg Sub Metering
plot(pwrSubset$Sub_metering_1~pwrSubset$dateTime, type="l", ylab="Energy sub metering", xlab="")
lines(pwrSubset$Sub_metering_2~pwrSubset$dateTime, col= "red")
lines(pwrSubset$Sub_metering_3~pwrSubset$dateTime, col= "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), bty = "n", cex=0.55, lty="solid")

#4th chart Global Reactive Power
plot(pwrSubset$Global_reactive_power~pwrSubset$dateTime, type="l", ylab="Global_reactive_power", xlab="datetime")

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

