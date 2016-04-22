library(stringr)
library(lubridate)

# Read in the data, clean it and change data types.
data=read.csv("household_power_consumption.txt", na.strings = "?", stringsAsFactors = F, sep=";")
colnames(data)=str_to_lower(colnames(data))
data$timestamp=dmy_hms(paste(data$date, data$time))

# Filter for the period between 2007-02-01 and 2007-02-02
data=data[difftime(data$timestamp, ymd_hms("2007-02-01 00:00:00"))>0 & difftime(data$timestamp, ymd_hms("2007-02-03 00:00:00"))<0,]

# Make the plot
png(file="plot3.png", width = 480, height = 480)
with(data, {
  plot(timestamp, sub_metering_1, ylab="Energy sub metering", main="", type="l", xlab="")
  lines(timestamp, sub_metering_2, type="l", col="red")
  lines(timestamp, sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)
})
dev.off()