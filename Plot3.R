# Exploratory Data Analysis - Assignment 2
#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question

library(ggplot2)

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset out Baltimore
Baltimore <- subset(summary, fips == 24510)

#Aggregate the data
aggBalt <- aggregate(Baltimore$Emissions, by = list(Baltimore$year, Baltimore$type), FUN = sum)


# Generate the graph in the same directory as the source code
png(filename="plot3.png", width = 1200, height=500, units='px')

ggplot(aggBalt, aes(Group.1, x)) + geom_line() + facet_grid(. ~ Group.2) + labs(x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons)"))


dev.off()