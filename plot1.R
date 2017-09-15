temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,temp,method = 'curl')
unzip(temp,"household_power_consumption.txt")
unlink(temp)
energy <- read.table('household_power_consumption.txt',sep=";",header=TRUE,na.strings = "?")
energy <- subset(energy,Date=='1/2/2007' | Date=='2/2/2007')
energy$Date <- strptime(energy$Date,'%d/%m/%Y')
energy$Date <- as.Date(energy$Date)

png(filename = "plot1.png",width = 480, height = 480)
with(energy,hist(Global_active_power,col='red',main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()
