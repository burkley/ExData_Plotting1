#
# Note: If this file is run, it will be necessary to create a "data" folder
# and copy the file "household_power_consumption.txt" to that folder.
#
library(dplyr)

# Read the data
data <- read.csv(file="data/household_power_consumption.txt", header=TRUE, sep=";" , stringsAsFactors=FALSE)

# Add a column to format the date string (column 1) to a "Date" object
data <- mutate(data, dateAsDate=as.Date(data$Date, format="%d/%m/%Y"))

# Now filter to get 1 Feb and 2 Feb 2007
filteredData <- filter(data, data$dateAsDate >= "2007-02-01" & data$dateAsDate <= "2007-02-02")

# 480 x 480 pixels is the default
pdf("Plot4.pdf");

# 2 rows and 2 columns
par(mfrow=c(2,2))

# Create the first plot, disable the default X axis tick makes as we will create that manually
with (filteredData,
      plot (Global_active_power,
            type="l",
            ylab="Global Active Power (kilowatts)",
            xaxt="n")
      )

# Add the X axis tick marks for the first plot
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# Create the second plot
with (filteredData,
      plot (Voltage,
            type="l",
            ylab="Voltage",
            xaxt="n")
      )

# Add the X axis tick marks for the second plot
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# Create the third plot
with (filteredData,
      plot (Sub_metering_1, type="l",
            ylab="Energy sub metering",
            col="black",
            xaxt="n")
      )

with (filteredData, lines(Sub_metering_2, type="l", col="red"))

with (filteredData, lines(Sub_metering_3, type="l", col="blue"))

# Add the X axis tick marks for the third plot
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# Add the legend for the third plot
legend("topright",
       lty=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

# Create the forth plot
with (filteredData,
      plot (Global_reactive_power,
            type="l",
            xaxt="n")
      )

# Add the X axis tick marks for the forth plot
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

dev.off()


