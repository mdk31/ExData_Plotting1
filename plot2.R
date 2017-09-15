library(dplyr)
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,temp,method = 'curl')
unzip(temp,"household_power_consumption.txt")
unlink(temp)
energy <- read.table('household_power_consumption.txt',sep=";",header=TRUE,na.strings = "?")
energy <- subset(energy,Date=='1/2/2007' | Date=='2/2/2007')
energy$Date <- strptime(energy$Date,'%d/%m/%Y')
energy$Date <- as.Date(energy$Date)
energy$date <- paste(energy$Date,energy$Time)
energy$date <- strptime(energy$date, "%Y-%m-%d %H:%M:%S")
energy <- select(energy,c(-Date,-Time))

png(filename = "plot2.png",width = 480, height = 480)
with(energy,plot(date,Global_active_power,type='l',ylab="Global active power",xlab=''))
dev.off()



