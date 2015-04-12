#Get Data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfilezip<-"file.zip"
download.file(url, destfilezip, method="curl", quiet = FALSE, mode = "w", cacheOK = TRUE)
#Read Data
data<-unzip ("file.zip", exdir = "./")
powerS <- read.table(text = grep("^[1,2]/2/2007",readLines(data),value=TRUE), sep =';',quote = "",na.string="?",check.names = TRUE)
unlink(data)
#powerS[,1]<-as.Date(powerS[,1])
colnames(powerS)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )
#Process Data
x <- paste(powerS$Date,powerS$Time)
powerS$Date_Time <-strptime(x, "%d/%m/%Y %H:%M:%S",tz = "GMT")
#Plot Data
with(powerS,plot(Date_Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)",xlab=""))
dev.copy(png,"plot2.png",width = 480, height = 480)
dev.off()