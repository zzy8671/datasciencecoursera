#Plot2:

getwd()
setwd("C:/Users/Zhiyi Zhang/Desktop/Data Science & Analytics/Data Science Specialization/4. Exploratory Data Analysis/Week 1")
t <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

t$Date <- as.Date(t$Date, format="%d/%m/%Y") #format is current format not target format
head(t$Date)
t2 <- subset(t, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
head(t2)

t2$datetime <- as.POSIXct(paste(t2$Date, t2$Time))

with(t2, plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.copy(png, "./plot2.png", width=480, height=480)
dev.off()
