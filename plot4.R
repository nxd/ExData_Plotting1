plot4 <- function(){
  # this function creates plot4 as a png
  
  # not sure the most efficient way to only read in 2 days of data, but given the structure of the data
  # I know that the 2 days of interest will be in the 11520 lines after skipping the first 63360
  # Not very elegant, but it works
  data1 <- read.table('household_power_consumption.txt', header = FALSE, skip = 63360, nrows = 11520, sep = ';', colClasses = "character")
  
  # retitle columns, since the header was not read in
  colnames(data1) <- c('date', 'time', 'Pglobal', 'Qglobal', 'voltage', 'Iglobal', 'submeter1', 'submeter2', 'submeter3')
  
  # extract data only for days of interest
  data1 <- data1[(data1$date == "1/2/2007" | data1$date == "2/2/2007"), ]
  
  # open png graphics device using filename
  png(file = "plot4.png")
  
  # set plot parameters to 2x2
  par(mfrow = c(2,2))
  
  # plot #1 in the upper left
  # same code as plot 2
  plot.ts(as.numeric(data1$Pglobal), ylab = 'Global Active Power (kilowatts)', xlab = NULL, xaxt = 'n')
  axis(side = 1, at = c(1,1440,2880), labels = c('Thu', 'Fri', 'Sat'))
  
  # plot #2 in the upper right
  plot.ts(as.numeric(data1$voltage), ylab = 'Voltage', xlab = NULL, xaxt = 'n')
  axis(side = 1, at = c(1,1440,2880), labels = c('Thu', 'Fri', 'Sat'))
  
  # plot #3 in the lower left
  # same code as plot 3, but remove box around submeter
  plot.ts(as.numeric(data1$submeter1), ylab = 'Energy sub metering', xlab = NULL, xaxt = 'n', type = 'n')
  lines(as.numeric(data1$submeter1), col = 'black', xlab = NULL, xaxt = 'n')
  lines(as.numeric(data1$submeter2), col = 'red', xlab = NULL, xaxt = 'n')
  lines(as.numeric(data1$submeter3), col = 'blue', xlab = NULL, xaxt = 'n')
  legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = c(1,1,1), bty = "n")
  axis(side = 1, at = c(1,1440,2880), labels = c('Thu', 'Fri', 'Sat'))
  
  # plot #4 in the lower right
  plot.ts(as.numeric(data1$Qglobal), ylab = 'GLobal_reactive_power', xlab = NULL, xaxt = 'n')
  axis(side = 1, at = c(1,1440,2880), labels = c('Thu', 'Fri', 'Sat'))
  
  # close png graphics device
  dev.off()
  
  return()
  
}