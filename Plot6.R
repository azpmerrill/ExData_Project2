# Exploratory Data Analysis - Assignment 2
#6.Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

summary$year <- factor(summary$year, levels=c('1999', '2002', '2005', '2008'))

#subsets data for each city and for motor vehicles only
BaltCars <- subset(summary, fips == '24510' & type == 'ON-ROAD')
LACars <- subset(summary, fips == '06037' & type == 'ON-ROAD')

# Aggregate
AggBalt <- aggregate(BaltCars[, 'Emissions'], by=list(BaltCars$year), sum)
colnames(AggBalt) <- c('year', 'Emissions')
AggBalt$City <- paste(rep("Baltimore", 4))

AggLA <- aggregate(LACars[, 'Emissions'], by=list(LACars$year), sum)
colnames(AggLA) <- c('year', 'Emissions')
AggLA$City <- paste(rep("LA", 4))

AggAll <- as.data.frame(rbind(AggBalt, AggLA))

# Generate the graph in the same directory as the source code
png('plot6.png')

ggplot(data=AggAll, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
        ggtitle('Comparison of Emissions of Vehicles') + 
        ylab(expression('Kilotons of PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()
