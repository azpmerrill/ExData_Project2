# Exploratory Data Analysis - Assignment 2
#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset out Baltimore
Baltimore <- subset(summary, fips == 24510)

# Generate the graph in the same directory as the source code
png(filename="plot2.png")

barplot(tapply(X=Baltimore$Emissions, INDEX=Baltimore$year, FUN=sum), 
        main=expression("Total Baltimore Emission of PM"[2.5]), 
        xlab="Year", ylab=expression(paste("Kilotons")))

dev.off()