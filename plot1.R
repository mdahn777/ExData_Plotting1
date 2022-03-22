#read data and create dataframe
power <- read.csv2("household_power_consumption.txt", sep=';', na.strings = "?")
head(power)

#create subset and fix character/numeric issue
actdata <- subset(power, Date %in% c("1/2/2007","2/2/2007"))
head(actdata)
actdata$Date <- as.Date(actdata$Date, format="%d/%m/%Y")
head(actdata)
class(actdata$Global_active_power)
actdata$Global_active_power <- as.numeric(actdata$Global_active_power)
class(actdata$Global_active_power)

#create histogram
hist(actdata$Global_active_power, breaks=12, col='red', main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

#save histogram
png("plot1.png", width=480, height=480)
hist(actdata$Global_active_power, breaks=12, col='red', main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
