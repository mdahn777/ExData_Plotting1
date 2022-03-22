#read data and create dataframe
power <- read.csv2("household_power_consumption.txt", sep=';', na.strings = "?")
head(power)

#add date and time merged column
datetime <- strptime(paste(power$Date, power$Time, sep=' '), "%d/%m/%Y %H:%M:%S")
power <- cbind(power, datetime)
head(power)

#subset data
actdata3 <- subset(power, Date %in% c("1/2/2007","2/2/2007"))
head(actdata3)
actdata3$Date <- as.Date(actdata3$Date, format="%d/%m/%Y")
head(actdata3)

#fix class issue
class <- sapply(actdata3, class)
class
actdata3$Sub_metering_1 <- as.numeric(actdata3$Sub_metering_1)
actdata3$Sub_metering_2 <- as.numeric(actdata3$Sub_metering_2)
actdata3$Sub_metering_3 <- as.numeric(actdata3$Sub_metering_3)
class <- sapply(actdata3, class)
class

#create line graph
with(actdata3, plot(datetime, Sub_metering_1, type='l', col='black', xlab='', 
                    ylab='Energy sub metering'))
lines(actdata3$datetime, actdata3$Sub_metering_2, col='red')
lines(actdata3$datetime, actdata3$Sub_metering_3, col='blue')
legend("topright", lty=1, col=c('black', 'red', 'blue'), 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

#save line graph
png("plot3.png", width=480, height=480)
with(actdata3, plot(datetime, Sub_metering_1, type='l', col='black', xlab='', ylab='Energy sub metering'))
lines(actdata3$datetime, actdata3$Sub_metering_2, col='red')
lines(actdata3$datetime, actdata3$Sub_metering_3, col='blue')
legend("topright", lty=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()