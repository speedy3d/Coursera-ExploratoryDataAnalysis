##Plot 4 - shows how coal combustion-related sources have changed from 1999 to 2008

#set working directory
setwd("../Exploratory Data Analysis/Project 2")

#import data from PM2.5 emissions RDS file
NEI <- readRDS("summarySCC_PM25.rds")

#import data from source classification code table RDS file
SCC <- readRDS("Source_Classification_Code.rds")

#Get coal combustion related rows, using grep to select rows containing the word "coal"
coal_SCC <- SCC[grep("coal", SCC$Short.Name, ignore.case=TRUE), ]

#Merge the SCC and NEI data sets to include only coal related sources
data_TotalEmissions_merged <- merge(x=NEI, y=coal_SCC, by="SCC")

#Get the sum of the total yearly emissions for coal
data_TotalEmissions_merged_sum <- aggregate(data_TotalEmissions_merged[ , "Emissions"], by=list(data_TotalEmissions_merged$year), sum)

#Apply correct column names
colnames(data_TotalEmissions_merged_sum) <- c('Year', 'Emissions')

#create the plot utilizing base graphics system
png("plot4.png")
plot(data_TotalEmissions_merged_sum$Year, data_TotalEmissions_merged_sum$Emissions, type="l", main="Total PM2.5 Emissions From Coal Sources in US", xlab="Year", ylab="Emissions (PM2.5)", col="red", lwd="2")
dev.off()