if(!file.exists("./data")){dir.create("./data")}

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile="./data/EPC.zip") #backup

download.file(fileUrl, destfile="./EPC")  #working directory

unzip("EPC.zip") 

## only takes months 2/1/2007 and 2/2/20017

EPC <- read.table(text = grep("^2/[1,2]/2007", readLines("household_power_consumption.txt"), value = TRUE),col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), header=TRUE, sep=";")

## this reads the whole table in

EPC2 <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

png("plot1.png", width=480, height=480)
hist(EPC$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (Kilowatts)",ylab="Frequency",ylim = c(0, 1200),breaks=6)
dev.off()