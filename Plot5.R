# Exploratory Data Analysis - Assignment 2
#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

summary$year <- factor(summary$year, levels=c('1999', '2002', '2005', '2008'))

#Subset out Baltimore
Baltimore <- subset(summary, fips == 24510)

#subsets out motor vehicles
BaltCars <- Baltimore[Baltimore$type == "ON-ROAD", ]

#Aggregate the data
aggBaltCars<- aggregate(BaltCars[, 'Emissions'], by=list(BaltCars$year), sum)
colnames(aggBaltCars) <- c('year', 'Emissions')

# Generate the graph in the same directory as the source code
png("plot5.png")
ggplot(data=aggBaltCars, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
        ggtitle('Total Emissions of Vehicles in Baltimore') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()
