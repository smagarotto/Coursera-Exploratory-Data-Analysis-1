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

png(filename = "plot2.png", width = 480, height = 480)
with(inputdata, plot(DateTime, GlobalActivePower, type = "l", main = "", 
                     xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

