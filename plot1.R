library(readr)
power <- read_delim("household_power_consumption.txt", 
                    ";", escape_double = FALSE, 
                    col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                    Global_active_power = col_number(), 
                    Global_intensity = col_number(), 
                    Global_reactive_power = col_number(),                                              
                    Sub_metering_1 = col_number(), Sub_metering_2 = col_number(),                                              
                    Sub_metering_3 = col_number(), Time = col_time(format = "%H:%M:%S"),                                              
                    Voltage = col_number()), na = "?", 
                    trim_ws = TRUE)
View(power)

library(plyr)
library(dplyr)

power_data <- filter(power, Date >= "2007-02-01" & Date <= "2007-02-02")

View(power_data)

png("plot1.png", width=480, height=480)

hist(power_data$Global_active_power, main = "Global Active Power", breaks = 12,
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()
