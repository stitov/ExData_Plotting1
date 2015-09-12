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
png ("plot3.png", width = 480, height = 480)
with (data, plot (Sub_metering_1 ~ DateTime, ylab = "Energy sub metering", 
      xlab = "", col = "black", type = "l"))
with (data, lines (Sub_metering_2 ~ DateTime, col = "red", type = "l"))
with (data, lines (Sub_metering_3 ~ DateTime, col = "blue", type = "l"))
legend ("topright", c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = 1, col = c("black", "red", "blue"))
dev.off()
