library(dplyr)
library(tidyverse)

data <- read.csv("household_power_consumption.txt", skip = 1, sep = ";", na.strings = "?", header = TRUE)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage","Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

data <- data %>%
  mutate(DateTime = paste(Date, Time, sep = " "))

data$DateTime <- as.POSIXct(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, ylab = "Energy Sub Metering", type = "l", xlab = "")
lines(data$DateTime, data$Sub_metering_2, type = "l", , col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", , col = "blue")

legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.copy(png, "plot3.png")
dev.off()

