# Read data
# First, ensure we have the appropriate support
library(sqldf)
input_file_name <- c("household_power_consumption.txt")
input_file <- input_file_name
df <- read.csv.sql(input_file, "select * from file where Date in ('1/2/2007','2/2/2007')",sep=";" )


# clean up the data
df [df=="?"]<-NA
df <-df[complete.cases(df),]


# Third plot
# ----------
date_time <- strptime(c(paste(df$Date,df$Time)),"%d/%m/%Y %H:%M:%S")
names(date_time) <- c("date_time")
df <- cbind(df,date_time)
# Plot3
# initial, first metter
par( mfrow = c(1,1), cex.lab=0.8)
with(df, 
plot(df$date_time,df$Sub_metering_1, type="l",
     xlab = "",
     ylab ="Energy sub metering"))
# add the second meter, with red color
with(df, 
     lines(df$date_time,df$Sub_metering_2, type="l",
          col="red"))
# add the third metter with blue color
with(df, 
     lines(df$date_time,df$Sub_metering_3, type="l",
           col="blue"))
# add the legend
legend("topright",  
       col = c("black","red","blue"), lty= c(1,1,1),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="plot3.png")
# closing the device
dev.off()
