# Start clean
rm(list=ls())

# Bring in the data
data<-read.table('household_power_consumption.txt', na.strings = '?', 
                 header = T, sep=';', stringsAsFactors = F)
data$DateTime<-strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format='%d/%m/%Y')

# Only want 2007-02-01 and 2007-02-02
indx<-which(data$Date=='2007-02-01' | data$Date=='2007-02-02')

p4data<-data[indx, ]

png('plot4.png', width = 480, height=480)
# up for 4 lots
par(mfrow = c(2, 2))

# top left
plot(x=p4data$DateTime, y=p4data$Global_active_power, col='black', 
     xlab="",
     ylab='Global Active Power (kilowatts)', type='l')

#top right
plot(x=p4data$DateTime, y=p4data$Voltage,
     xlab='datetime', ylab='Voltage', type='l')

# bottom left
plot(x=p4data$DateTime, y=p4data$Sub_metering_1,
     xlab="",
     ylab='Energy sub metering', 
     ylim=range(c(p4data$Sub_metering_1, p4data$Sub_metering_2, p4data$Sub_metering_3)),
     type='n')
lines(x=p4data$DateTime, y=p4data$Sub_metering_1, col='black')
lines(x=p4data$DateTime, y=p4data$Sub_metering_2, col='red')
lines(x=p4data$DateTime, y=p4data$Sub_metering_3, col='blue')
legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=1)

# bottom right
plot(x=p4data$DateTime, y=p4data$Global_reactive_power,
     xlab='datetime', ylab='Global_reactive_power', type='l')

dev.off()
