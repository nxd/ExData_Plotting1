plot1 <- function(){
  # this function creates plot1 as a png
  
  # not sure the most efficient way to only read in 2 days of data, but given the structure of the data
  # I know that the 2 days of interest will be in the 11520 lines after skipping the first 63360
  # Not very elegant, but it works
  data1 <- read.table('household_power_consumption.txt', header = FALSE, skip = 63360, nrows = 11520, sep = ';', colClasses = "character")
  
  # retitle columns, since the header was not read in
  colnames(data1) <- c('date', 'time', 'Pglobal', 'Qglobal', 'voltage', 'Iglobal', 'submeter1', 'submeter2', 'submeter3')
  
  # extract data only for days of interest
  data1 <- data1[(data1$date == "1/2/2007" | data1$date == "2/2/2007"), ]
  
  # open png graphics device using filename
  png(file = "plot1.png")
  
  # plot histogram with proper data, labels, and color
  hist(as.numeric(data1$Pglobal), col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
  
  # close png graphics device
  dev.off()
  
  return()
}




