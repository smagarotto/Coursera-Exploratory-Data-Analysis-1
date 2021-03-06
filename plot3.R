library(data.table)
setwd(paste(getwd(), "/exdata_data_household_power_consumption", sep=""))
inputdata <- read.table("household_power_consumption.txt", sep=";", na="?",
                        col.names = c("Date","DateTime","GlobalActivePower","GlobalReactivePower",
                                      "Voltage","GlobalIntensity","SubMeteringKitchen",
                                      "SubMeteringLaundry","SubMeteringWaterHeater"),
                        colClasses = c(rep("character",2),rep("numeric",7)),header = TRUE)
inputdata$Date<-strptime(x = inputdata$Date,format = "%d/%m/%Y")
inputdata<-subset(inputdata,Date>"2007-01-31" & Date<"2007-02-03")
inputdata$Date<-paste(inputdata$Date,inputdata$DateTime)
inputdata$DateTime<-strptime(x = inputdata$Date,format = "%Y-%m-%d %H:%M:%S")
inputdata$Date<-NULL

png(filename = "plot3.png", width = 480, height = 480)
with(inputdata, plot(DateTime, SubMeteringKitchen, 
          type = "l", main = "", xlab = "", col = "black",
          ylab = "Energy sub metering"))
with(inputdata, points(DateTime, SubMeteringLaundry, type = "l", col = "red"))
with(inputdata, points(DateTime, SubMeteringWaterHeater, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

