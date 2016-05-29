# Start clean
rm(list=ls())

# Bring in the data
data<-read.table('household_power_consumption.txt', na.strings = '?', 
                 header = T, sep=';', stringsAsFactors = F)
data$DateTime<-strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format='%d/%m/%Y')

# Only want 2007-02-01 and 2007-02-02
indx<-which(data$Date=='2007-02-01' | data$Date=='2007-02-02')

p2data<-data[indx, ]

png('plot2.png', width = 480, height=480)
plot(x=p2data$DateTime, y=p2data$Global_active_power, col='black', 
     xlab="",
     ylab='Global Active Power (kilowatts)', type='l')
dev.off()
