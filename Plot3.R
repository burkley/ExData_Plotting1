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
pdf("Plot3.pdf");

# Create the plot with the first data set, disable the default X axis tick makes as we will create that manually
with (filteredData,
      plot (Sub_metering_1, type="l",
            ylab="Energy sub metering",
            col="black",
            xaxt="n")
      )

# Add the second data set
with (filteredData, lines(Sub_metering_2, type="l", col="red"))

# Add the third data set
with (filteredData, lines(Sub_metering_3, type="l", col="blue"))

# Add the X axis tick marks
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# Add the legend
legend("topright",
       lty=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

# Finally close the PDF file (graphics device)
dev.off()

