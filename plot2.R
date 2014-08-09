# Read data
# First, ensure we have the appropriate support
library(sqldf)
input_file_name <- c("household_power_consumption.txt")
input_file <- input_file_name
df <- read.csv.sql(input_file, "select * from file where Date in ('1/2/2007','2/2/2007')",sep=";" )


# clean up the data
df [df=="?"]<-NA
df <-df[complete.cases(df),]


# Second plot
# ----------
# This is an unused column, however can be used

week_day <- format(as.Date(df$Date,"%d/%m/%Y"),"%A")
names(week_day) <- c("WeekDay")
df <- cbind(df,week_day)
    
date_time <- strptime(c(paste(df$Date,df$Time)),"%d/%m/%Y %H:%M:%S")
names(date_time) <- c("date_time")
df <- cbind(df,date_time)

# Either open here the output png device, default size is 480x480
# png(filename="plot2.png")

# Plot2
par( mfrow = c(1,1), cex.lab=0.8)
plot(df$date_time,df$Global_active_power, type="l",
     xlab = "",
     ylab ="Global Active Power (kilowatts)")
# if you open above a png device, comment out the following statement
dev.copy(png,file="plot2.png")
# close the device
dev.off()
rm(df, week_day,date_time)
