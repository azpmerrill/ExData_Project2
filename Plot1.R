# Exploratory Data Analysis - Assignment 2
#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate by year
emissions <- aggregate(summary[, 'Emissions'], by=list(summary$year), FUN=sum)
emissions$PM <- round(emissions[,2]/1000,2)

# Generate the graph in the same directory as the source code
png(filename="plot1.png")

barplot(emissions$PM, names.arg=emissions$Group.1, 
        main=expression("Total US Emission of PM"[2.5]),
        xlab='Year', ylab=expression(paste("Kilotons")))

dev.off()