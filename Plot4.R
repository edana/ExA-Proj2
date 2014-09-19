#Check that the files exist in the current directory
files<-dir()
if("Source_Classification_Code.rds" %in% files) {
    print("The file Source_Classification_Code.rds was found.")
}
if("summarySCC_PM25.rds" %in% files) {
    print("The file summarySCC_PM25.rds was found.")
}    

#Open the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total coal emissions 
coal_SCC <- SCC[grep("[Cc]oal",SCC$Short.Name),1]
coal_NEI <- NEI[(NEI$SCC %in% coal_SCC),]

totalNEI <- aggregate(Emissions ~ year, coal_NEI, sum)

#Make the plot
png(file = "plot4.png")
require(ggplot2)

g <- ggplot(totalNEI, aes(year, Emissions, colour = "red"))
g + geom_point(size = 3) + geom_line() + theme(legend.position="none") + ggtitle("Coal combusttion-related emmisions")
dev.off()
