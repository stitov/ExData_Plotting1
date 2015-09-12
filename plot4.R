# set system locale for weekdays plot (Windows)
Sys.setlocale("LC_ALL", 'English')

library (dplyr)
#setwd ("C:/Github/ExData_Plotting1")

# load data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (file_url, "data.zip")
data <-  read.table (unzip ("data.zip"), na.strings = "?", header = T, sep = ";", 
                     colClasses = c (rep ("character", 2), rep ("numeric", 7)))

# transform data
data <- data %>% 
    mutate (DateTime = as.POSIXct (strptime (paste (Date, Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
    filter (DateTime >= as.POSIXct("2007-02-01") & DateTime <= as.POSIXct ("2007-02-02 23:59:59")) %>%
    select (DateTime, 3:9)

# plot data
png ("plot4.png", width = 480, height = 480)
par (mfrow = c (2,2))
# plot 1
with (data, plot (Global_active_power ~ DateTime, ylab = "Global Active Power", 
                  xlab = "", col = "black", type = "l"))
# plot 2
with (data, plot (Voltage ~ DateTime, ylab = "Voltage", 
                  xlab = "datetime", col = "black", type = "l"))
# plot 3
with (data, plot (Sub_metering_1 ~ DateTime, ylab = "Energy sub metering", 
      xlab = "", col = "black", type = "l"))
with (data, lines (Sub_metering_2 ~ DateTime, col = "red", type = "l"))
with (data, lines (Sub_metering_3 ~ DateTime, col = "blue", type = "l"))
legend ("topright", c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = 1, col = c("black", "red", "blue"))
# plot 4
with (data, plot (Global_reactive_power ~ DateTime, ylab = "Global_reactive_power", 
                  xlab = "datetime", col = "black", type = "l"))
dev.off()
