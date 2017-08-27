
setwd("C:/Users/e79309/Documents/Coursera_DataScience/4.ExploratoryDataAnalysis/Week1")
power <- read.table("./household_power_consumption.txt", sep=";", dec=".", header=TRUE)
head(power)
power$datetime <- paste(power$Date, power$Time)
power$Date2 <- strptime(as.Date(power$Date), "%d/%m/%y")

subset <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
dim(subset)
head(subset)

## plot2
subset$datetime <- paste(subset$Date, subset$Time)
subset$datetime2 <- strptime(subset$datetime, "%d/%m/%Y %H:%M:%S")
png(filename="plot2.png")
plot(subset$datetime2,as.numeric(as.character(subset$Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()