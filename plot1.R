# Read data
# First, ensure we have the appropriate support
library(sqldf)
input_file_name <- c("household_power_consumption.txt")
input_file <- input_file_name
df <- read.csv.sql(input_file, "select * from file where Date in ('1/2/2007','2/2/2007')",sep=";" )


# clean up the data
df [df=="?"]<-NA
df <-df[complete.cases(df),]

# First Plot
# ----------
# Plot1

# Either open here the output png device, default size is 480x480
# and comment out the dev.copy or the reverse
# png(filename="plot1.png")
par( mfrow = c(1,1), cex.lab=0.8)
hist(df$Global_active_power, col="red",
     main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)")
# if you open above a png device, comment out the following statement
dev.copy(png,file="plot2.png")
# closing the device
dev.off()

# clean up
rm(df)

