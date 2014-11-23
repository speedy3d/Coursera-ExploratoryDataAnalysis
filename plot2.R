##Plot 2 - shows total PM2.5 emission from all sources for each of the years (1999,2002,2005,2008) in baltimore

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Subset baltimore only data (fips=24510)
baltimore_Subset <- subset(NEI, fips == "24510")

#Use aggregate function to find emission from all sources for 1999,2002,2005, and 2008 using baltimore subset of the data
data_TotalEmissions <- aggregate(baltimore_Subset[c("Emissions")], list(year=baltimore_Subset$year), sum)

#create the plot utilizing type "line," color "red," and thickness "2"
png("plot2.png")
plot(data_TotalEmissions$year, data_TotalEmissions$Emissions, type="l", main="Total PM2.5 Emissions From Baltimore", xlab="Year", ylab="Emissions", col="red", lwd="2")
dev.off()