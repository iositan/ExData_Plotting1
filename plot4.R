# Read data
# First, ensure we have the appropriate support
library(sqldf)
input_file_name <- c("household_power_consumption.txt")
input_file <- input_file_name
df <- read.csv.sql(input_file, "select * from file where Date in ('1/2/2007','2/2/2007')",sep=";" )


# clean up the data
df [df=="?"]<-NA
df <-df[complete.cases(df),]


# Fourth plot
# ----------
date_time <- strptime(c(paste(df$Date,df$Time)),"%d/%m/%Y %H:%M:%S")
names(date_time) <- c("date_time")
df <- cbind(df,date_time)
# Plot4
png(filename="plot4.png")
par(mfrow =c (2,2))
# a) First plot, upper left
with(df, 
plot(df$date_time,df$Global_active_power, type="l",
     xlab = "",
     ylab ="Global Active Power"), cex=0.5)
# b) add the second plot
with(df, 
     plot(df$date_time,df$Voltage, type="l",
          xlab = "datetime",
          ylab ="Voltage"), cex=0.5)
# c) add the third plot. 
# This one is copy from plot3
with(df, 
     plot(df$date_time,df$Sub_metering_1, type="l",
          xlab = "",
          ylab ="Energy sub metering"), cex=0.5)
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
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.8, bty="n")

# d) The fourth plot
with(df, 
     plot(df$date_time,df$Global_reactive_power, type="l",
          xlab = "datetime",
          ylab ="Global_Reactive_Power"))
#dev.copy(png,file="plot4.png")
# closing the device
dev.off()
