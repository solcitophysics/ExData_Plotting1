#Get Data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfilezip<-"file.zip"
download.file(url, destfilezip, method="curl", quiet = FALSE, mode = "w", cacheOK = TRUE)
#Read Data
data<-unzip ("file.zip", exdir = "./")
powerS <- read.table(text = grep("^[1,2]/2/2007",readLines(data),value=TRUE), sep =';',quote = "",na.string="?",check.names = TRUE)
unlink(data)
#Process Data
colnames(powerS)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )
x <- paste(powerS$Date,powerS$Time)
powerS$Date_Time <-strptime(x, "%d/%m/%Y %H:%M:%S",tz = "GMT")

#Plot Data
with(powerS, plot(Date_Time,Sub_metering_1, type="l", ylab = "Energy Sub Metering",xlab="", col="grey"))
points(powerS$Date_Time, powerS$Sub_metering_2, type="l", col="red")
points(powerS$Date_Time, powerS$Sub_metering_3, type="l", col="blue")
legend("topright", lty = 1, col =c("grey", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png",width = 480, height = 480)
dev.off()