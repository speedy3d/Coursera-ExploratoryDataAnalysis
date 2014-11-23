##Plot 3 - shows total PM2.5 emission for each of the years (1999,2002,2005,2008) in baltimore broken down by source

#get required library
library(ggplot2)

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Subset baltimore only data (fips=24510)
baltimore_Subset <- subset(NEI, fips == "24510")

#Use aggregate function to find emission for 1999,2002,2005, and 2008 using baltimore subset of the data broken down by source
data_TotalEmissions <- aggregate(baltimore_Subset[c("Emissions")], list(type=baltimore_Subset$type, year=baltimore_Subset$year), sum)

#create the plot utilizing ggplot2 qplot method. Using smoother (method loess) to smooth connections between points
png("plot3.png")
chart <- qplot(year, Emissions, data = data_TotalEmissions, geom=c("point","smooth"), method="loess", colour=type, ylab= "Emissions (PM 2.5)", xlab= "Year", main= "Total Emissions for Baltimore by Type")
print(chart)
dev.off()