library(stringr)
library(lubridate)

# Read in the data, clean it and change data types.
data=read.csv("household_power_consumption.txt", na.strings = "?", stringsAsFactors = F, sep=";")
colnames(data)=str_to_lower(colnames(data))
data$timestamp=dmy_hms(paste(data$date, data$time))

# Filter for the period between 2007-02-01 and 2007-02-02
data=data[difftime(data$timestamp, ymd_hms("2007-02-01 00:00:00"))>0 & difftime(data$timestamp, ymd_hms("2007-02-03 00:00:00"))<0,]

# Make the plot
png(file="plot2.png", width = 480, height = 480)
with(data, plot(timestamp, global_active_power, ylab="Global Active Power [kW]", main="", type="l", xlab=""))
dev.off()