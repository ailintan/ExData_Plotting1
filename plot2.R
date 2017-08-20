#downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#downloadFile <- "./Data/household_power_consumption.zip"
#householdFile <- "./Data/household_power_consumption.txt"

#check file exists before download and unzip
#if (!file.exists(householdFile)) {
#   download.file(downloadURL, downloadFile, method = "curl")
#   unzip(downloadFile, overwrite = T, exdir = "./Data")
#}

# read household_power_consumption.txt excluding missing values
pwr <- read.table("household_power_consumption.txt", header= TRUE, sep=";", na.strings="?")

#convert date to Date class
pwr$Date <- as.Date(pwr$Date,"%d/%m/%Y")

#Select only data from 2007-02-01 to 2007-02-02
pwr <- subset(pwr, Date >= "2007-02-01" & Date <= "2007-02-02");

#Convert the Date and Time variables to Date/Time classes 
dateTime <- paste(pwr$Date, pwr$Time)
dateTime <- as.POSIXct(dateTime)
pwr <- cbind(dateTime, pwr)

#plot the chart
y <- plot(pwr$Global_active_power~pwr$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

