# Plot 1: Global Active Power
getwd()
setwd("C:/Users/Zhiyi Zhang/Desktop/Data Science & Analytics/Data Science Specialization/4. Exploratory Data Analysis/Week 1")
t <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

t$Date <- as.Date(t$Date, format="%d/%m/%Y") #format is current format not target format
head(t$Date)
t2 <- subset(t, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
head(t2)

hist(t2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

dev.copy(png, "./plot1.png", width=480, height=480)
dev.off()
