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

# create plot1.png Graphics File Device
png("plot1.png")

# create plot1 
hist(df_feb$Global_active_power, col = "red", main = "Glocal Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0,1200))

# close plot1.png
dev.off()