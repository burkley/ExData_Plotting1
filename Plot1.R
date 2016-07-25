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
pdf("Plot1.pdf");

# Create the plot
with(data,
     hist(as.numeric(filteredData$Global_active_power),
          col="red",
          main="Global Active Power",
          xlab="Global Active Power (kilowatts)")
     )

# Finally close the PDF file (graphics device)
dev.off()

