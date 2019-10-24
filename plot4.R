if(!file.exists("./data")){dir.create("./data")}

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile="./data/EPC.zip") #backup

download.file(fileUrl, destfile="./EPC")  #working directory

unzip("EPC.zip") 

## only takes months 2/1/2007 and 2/2/20017

EPC <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE),col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), header=False, sep=";")

## this reads the whole table n

EPC_ALL <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

EPC2<-EPC

#formats the date

EPC2$Date <- as.Date(EPC2$Date, format = "%d/%m/%Y")

## Date and time 

datetime <- paste(as.Date(EPC2$Date), EPC2$Time)
EPC2$datetime <- as.POSIXct(datetime)

png("plot4.png", width=480, height=480)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

plot(EPC2$Global_active_power ~ EPC2$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "",ylim = c(0, 6))


plot(EPC2$Voltage ~ EPC2$datetime, type = "l", ylab = "Voltage", xlab = "DateTime")

with(EPC2, {
  plot(Sub_metering_1 ~ datetime, type = "l", 
       ylab = "Energy Sub Metering", xlab = "",ylim = c(0, 30))
  lines(Sub_metering_2 ~ datetime, col = 'Red')
  lines(Sub_metering_3 ~ datetime, col = 'Blue')
})


legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


plot(EPC2$Global_reactive_power ~ EPC2$datetime, type = "l", ylab = "Global_reactive_power", xlab = "DateTime")
dev.off()