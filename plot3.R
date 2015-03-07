plot3 <- function(){
  # this function creates plot3 as a png
  
  # not sure the most efficient way to only read in 2 days of data, but given the structure of the data
  # I know that the 2 days of interest will be in the 11520 lines after skipping the first 63360
  # Not very elegant, but it works
  data1 <- read.table('household_power_consumption.txt', header = FALSE, skip = 63360, nrows = 11520, sep = ';', colClasses = "character")
  
  # retitle columns, since the header was not read in
  colnames(data1) <- c('date', 'time', 'Pglobal', 'Qglobal', 'voltage', 'Iglobal', 'submeter1', 'submeter2', 'submeter3')
  
  # extract data only for days of interest
  data1 <- data1[(data1$date == "1/2/2007" | data1$date == "2/2/2007"), ]
  
  # open png graphics device using filename
  png(file = "plot3.png")
  
  # create an empty plot using type = 'n'
  plot.ts(as.numeric(data1$submeter1), ylab = 'Energy sub metering', xlab = NULL, xaxt = 'n', type = 'n')
  
  # add lines for each submeter using proper color
  lines(as.numeric(data1$submeter1), col = 'black', xlab = NULL, xaxt = 'n')
  lines(as.numeric(data1$submeter2), col = 'red', xlab = NULL, xaxt = 'n')
  lines(as.numeric(data1$submeter3), col = 'blue', xlab = NULL, xaxt = 'n')
  
  # add legend, color and text
  legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = c(1,1,1))
  
  # add custom x-axis label
  axis(side = 1, at = c(1,1440,2880), labels = c('Thu', 'Fri', 'Sat'))
  
  # close png graphics device
  dev.off()
  
  return()
  
}