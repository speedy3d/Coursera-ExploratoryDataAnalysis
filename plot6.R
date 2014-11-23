##Plot 6 - Compares total PM2.5 emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California

#get required library
library(ggplot2)

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Get subset related to Balitmore (fips=24510), and Los Angeles (fips=06037)
data_TotalEmissions_road_bal <- subset(NEI, type=="ON-ROAD" & fips=="24510")
data_TotalEmissions_road_los <- subset(NEI, type=="ON-ROAD" & fips=="06037")

#Get the sum of the total yearly emissions for on-road type in Baltimore then replicate values/add new column to represent the state
data_TotalEmissions_road_sum_bal <- aggregate(data_TotalEmissions_road_bal[ , "Emissions"], by=list(data_TotalEmissions_road_bal$year), sum)
data_TotalEmissions_road_sum_bal$City <- paste(rep("Baltimore City",4))

#Get the sum of the total yearly emissions for on-road type in Los Angeles then replicate values/add new column to represent the state
data_TotalEmissions_road_sum_los <- aggregate(data_TotalEmissions_road_los[ , "Emissions"], by=list(data_TotalEmissions_road_los$year), sum)
data_TotalEmissions_road_sum_los$City <- paste(rep("Los Angeles County",4))

#Apply correct column names
colnames(data_TotalEmissions_road_sum_bal) <- c("Year", "Emissions", "City")
colnames(data_TotalEmissions_road_sum_los) <- c("Year", "Emissions", "City")

#Merge the two data subsets
data_data_TotalEmissions_road_merged <- as.data.frame(rbind(data_TotalEmissions_road_sum_bal, data_TotalEmissions_road_sum_los))

#Create the plot using ggplot2 to compare total on-road emissions between Baltimore and Los Angeles
png("plot6.png")
chart <- qplot(Year, Emissions, data = data_data_TotalEmissions_road_merged, geom=c("point","smooth"), method="loess", colour=City, ylab= "Emissions (PM 2.5)", xlab= "Year", main= "Total On Road Emissions for Baltimore Vs Los Angeles")
print(chart)
dev.off()

