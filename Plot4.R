# Exploratory Data Analysis - Assignment 2
#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

# Loading Datasets from working directory 
summary <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal combustion related sources
Coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge two data sets
merge <- merge(x=summary, y=Coal, by='SCC')
aggmerge <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(aggmerge) <- c('Year', 'Emissions')


# Generate the graph in the same directory as the source code
png(filename="plot4.png")

ggplot(data=aggmerge, aes(x=Year, y=Emissions/1000)) + 
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
        ggtitle(expression('Total Coal Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

dev.off()