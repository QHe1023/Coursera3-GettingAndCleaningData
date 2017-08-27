
setwd("C:/Users/e79309/Documents/Coursera_DataScience/4.ExploratoryDataAnalysis/Week1")
power <- read.table("./household_power_consumption.txt", sep=";", dec=".", header=TRUE)
head(power)
power$datetime <- paste(power$Date, power$Time)
power$Date2 <- strptime(as.Date(power$Date), "%d/%m/%y")

subset <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
dim(subset)
head(subset)

## plot1
png(filename="plot1.png")
hist(as.numeric(subset$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency",
     main="Global Active Power")
dev.off()