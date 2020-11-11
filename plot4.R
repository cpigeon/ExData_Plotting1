library(datasets)

# create a filename 
filename <- "Electrical_Power_Consumption.zip"

# check if the archive exists
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = filename)
}

# check if the folder exists
if (!file.exists("exdata_data_household_power_consumption.zip")) {
  unzip(filename)
}

# read in the data
df_tot <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";",
                   na.strings = "?", stringsAsFactors = FALSE)

# convert Date column to Date class using strptime
df_tot$Date <- as.Date(df_tot$Date, format = "%d/%m/%Y")

# subset the data frame so that we have a smaller data frame of dates equal 
# to 2007-02-01 and 2007-02-02
df_feb <- subset(df_tot, Date == "2007-02-01" | Date == "2007-02-02")

# combine date & time into one column 
datetime <- as.POSIXct(paste(df_feb$Date, df_feb$Time), format="%Y-%m-%d %H:%M:%S")

# create plot4.png Graphics File Device
png("plot4.png")

# create plot4
par(mfrow = c(2,2))
# plot for row1/col1 
plot(datetime, df_feb$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")

# plot for row1/col2 
plot(datetime, df_feb$Voltage, type = "l", col = "black", ylab = "Voltage")

# plot for row2/col1 
plot(datetime, df_feb$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy Sub Metering")
lines(datetime, df_feb$Sub_metering_2, col = "red")
lines(datetime, df_feb$Sub_metering_3, col = "blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1))

#plot for row2/col2
plot(datetime, df_feb$Global_reactive_power, type = "l", ylab = "Global Reactive Power")

# close plot4.png
dev.off()