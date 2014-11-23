##Plot 1 - shows total PM2.5 emission from all sources for each of the years (1999,2002,2005,2008)

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Use aggregate function to find emission from all sources for 1999,2002,2005, and 2008
data_TotalEmissions <- aggregate(NEI[c("Emissions")], list(year=NEI$year), sum)

#create the plot utilizing type "line" and color "red" and thickness "2"
png("plot1.png")
plot(data_TotalEmissions$year, data_TotalEmissions$Emissions, type="l", main="Total PM2.5 Emissions From All Sources", xlab="Year", ylab="Emissions", col="red", lwd="2")
dev.off()
