#read data and create dataframe
power <- read.csv2("household_power_consumption.txt", sep=';', na.strings = "?")
head(power)

#add date and time merged column
datetime <- strptime(paste(power$Date, power$Time, sep=' '), "%d/%m/%Y %H:%M:%S")
power <- cbind(power, datetime)
head(power)

#subset to days needed; changed date
actdata4 <- subset(power, Date %in% c("1/2/2007","2/2/2007"))
head(actdata4)
actdata4$Date <- as.Date(actdata4$Date, format="%d/%m/%Y")
head(actdata4)

#fix class issues
class <- sapply(actdata4, class)
class
#global active power
actdata4$Global_active_power <- as.numeric(actdata4$Global_active_power)
#voltage
actdata4$Voltage <- as.numeric(actdata4$Voltage)
#sub meter 1
actdata4$Sub_metering_1 <- as.numeric(actdata4$Sub_metering_1)
#sub meter 2
actdata4$Sub_metering_2 <- as.numeric(actdata4$Sub_metering_2)
#sub meter 3
actdata4$Sub_metering_3 <- as.numeric(actdata4$Sub_metering_3)
#global reactive power
actdata4$Global_reactive_power <- as.numeric(actdata4$Global_reactive_power)
class <- sapply(actdata4, class)
class

#top left graph
#plot2 graph
with(actdata4, plot(datetime, Global_active_power, type='l', 
                    ylab="Global Active Power (kilowatts)", xlab=""))

#bottom left graph
#plot 3 graph <- difference is adding bty='n' to remove legend box border
with(actdata4, plot(datetime, Sub_metering_1, type='l', col='black', 
                    xlab='', ylab='Energy sub metering'))
lines(actdata4$datetime, actdata4$Sub_metering_2, col='red')
lines(actdata4$datetime, actdata4$Sub_metering_3, col='blue')
legend("topright", bty='n', lty=1, col=c('black', 'red', 'blue'), 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

#top right graph
#looks similar to plot 2
with(actdata4, plot(datetime, Voltage, type='l'))

#bottom right graph
#looks similar to plot 2
with(actdata4, plot(datetime, Global_reactive_power, type='l'))

#put all graphs together
par(mfcol=c(2, 2))
#plot 1
with(actdata4, plot(datetime, Global_active_power, type='l', 
                    ylab="Global Active Power (kilowatts)", xlab=""))
#plot 2
with(actdata4, plot(datetime, Sub_metering_1, type='l', col='black', 
                    xlab='', ylab='Energy sub metering'))
lines(actdata4$datetime, actdata4$Sub_metering_2, col='red')
lines(actdata4$datetime, actdata4$Sub_metering_3, col='blue')
legend("topright", bty='n', lty=1, col=c('black', 'red', 'blue'), 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
#plot 3
with(actdata4, plot(datetime, Voltage, type='l'))
#plot 4
with(actdata4, plot(datetime, Global_reactive_power, type='l'))

#save four graph png
png("plot4.png", width=480, height=480)
    par(mfcol=c(2, 2))
    with(actdata4, plot(datetime, Global_active_power, type='l', 
                        ylab="Global Active Power (kilowatts)", xlab=""))
    with(actdata4, plot(datetime, Sub_metering_1, type='l', col='black', 
                        xlab='', ylab='Energy sub metering'))
    lines(actdata4$datetime, actdata4$Sub_metering_2, col='red')
    lines(actdata4$datetime, actdata4$Sub_metering_3, col='blue')
    legend("topright", bty='n', lty=1, col=c('black', 'red', 'blue'), 
        legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
    with(actdata4, plot(datetime, Voltage, type='l'))
    with(actdata4, plot(datetime, Global_reactive_power, type='l'))
dev.off()
