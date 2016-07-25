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
pdf("Plot2.pdf");

# Create the plot, disable the default X axis tick makes as we will create that manually
with (filteredData,
      plot (Global_active_power,
            type="l",
            ylab="Global Active Power (kilowatts)",
            xaxt="n")
      )

# Add the X axis tick marks
axis(side=1,at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# Finally close the PDF file (graphics device)
dev.off()


