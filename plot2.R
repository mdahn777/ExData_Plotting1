#read data and create dataframe
power <- read.csv2("household_power_consumption.txt", sep=';', na.strings = "?")
head(power)

#add date and time merged column
datetime <- strptime(paste(power$Date, power$Time, sep=' '), "%d/%m/%Y %H:%M:%S")
power <- cbind(power, datetime)
head(power)

#subset data and fix class issue
actdata2 <- subset(power, Date %in% c("1/2/2007","2/2/2007"))
head(actdata2)
actdata2$Date <- as.Date(actdata2$Date, format="%d/%m/%Y")
head(actdata2)
class(actdata2$Global_active_power)
actdata2$Global_active_power <- as.numeric(actdata2$Global_active_power)
class(actdata2$Global_active_power)

#create line graph
with(actdata2, plot(datetime, Global_active_power, type='l', 
                    ylab="Global Active Power (kilowatts)", xlab=""))

#save linegraph
png("plot2.png", width=480, height=480)
with(actdata2, plot(datetime, Global_active_power, type='l', 
                    ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
