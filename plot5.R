##Plot 5 - shows how emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Get subset related to Balitmore (fips=24510)
data_TotalEmissions_road <- subset(NEI, type=="ON-ROAD" & fips==24510)

#Get the sum of the total yearly emissions for on-road type in Baltimore
data_TotalEmissions_road_sum <- aggregate(data_TotalEmissions_road[ , "Emissions"], by=list(data_TotalEmissions_road$year), sum)

#Apply correct column names
colnames(data_TotalEmissions_road_sum) <- c("Year", "Emissions")

#create the plot utilizing base graphics system
png("plot5.png")
plot(data_TotalEmissions_road_sum$Year, data_TotalEmissions_road_sum$Emissions, type="l", main="Total PM2.5 Emissions From Road Sources in Baltimore", xlab="Year", ylab="Emissions (PM2.5)", col="red", lwd="2")
dev.off()