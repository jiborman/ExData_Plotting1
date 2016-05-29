# Start clean
rm(list=ls())

# Bring in the data
data<-read.table('household_power_consumption.txt', na.strings = '?', 
                 header = T, sep=';', stringsAsFactors = F)
data$DateTime<-strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format='%d/%m/%Y')

# Only want 2007-02-01 and 2007-02-02
indx<-which(data$Date=='2007-02-01' | data$Date=='2007-02-02')

p3data<-data[indx, ]

png('plot3.png', width = 480, height=480)
plot(x=p3data$DateTime, y=p3data$Sub_metering_1,
     xlab="",
     ylab='Energy sub metering', 
     ylim=range(c(p3data$Sub_metering_1, p3data$Sub_metering_2, p3data$Sub_metering_3)),
     type='n')
lines(x=p3data$DateTime, y=p3data$Sub_metering_1, col='black')
lines(x=p3data$DateTime, y=p3data$Sub_metering_2, col='red')
lines(x=p3data$DateTime, y=p3data$Sub_metering_3, col='blue')
legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=1)
dev.off()
