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

png(filename = "plot3.png",width = 480, height = 480)
with(energy,plot(date,Sub_metering_1,type='l',ylab="Energy sub metering",xlab=''))
with(energy,lines(date,Sub_metering_2,type='l',col='red'))
with(energy,lines(date,Sub_metering_3,type='l',col='blue'))
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=c(1,1,1),cex=0.8)
dev.off()



