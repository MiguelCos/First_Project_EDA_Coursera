power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                  "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

power_date <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

power_date$Date <- as.Date(power_date$Date, format="%d/%m/%Y")
power_date$Time <- strptime(power_date$Time, format = "%H:%M:%S")
power_date[1:1440,"Time"] <- format(power_date[1:1440,"Time"],"2007-02-01 %H:%M:%S")
power_date[1441:2880,"Time"] <- format(power_date[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

with(power_date,{
  plot(power_date$Time,as.numeric(as.character(power_date$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(power_date$Time,as.numeric(as.character(power_date$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(power_date$Time,power_date$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(power_date,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(power_date,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(power_date,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(power_date$Time,as.numeric(as.character(power_date$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()
