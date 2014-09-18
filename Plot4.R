files<-dir()
if("Source_Classification_Code.rds" %in% files) {
    print("The file Source_Classification_Code.rds was found.")
}
if("summarySCC_PM25.rds" %in% files) {
    print("The file summarySCC_PM25.rds was found.")
}    
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_SCC <- SCC[grep("[Cc]oal",SCC$Short.Name),1]
coal_NEI <- NEI[(NEI$SCC %in% coal_SCC),]

totalNEI <- aggregate(Emissions ~ year, coal_NEI, sum)

require(ggplot2)

g <- ggplot(totalNEI, aes(year, Emissions, colour = "red"))
g + geom_point(size = 3) + geom_line() + theme(legend.position="none") + ggtitle("Coal combusttion-related emmisions")
