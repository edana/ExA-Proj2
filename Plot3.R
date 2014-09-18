files<-dir()
if("Source_Classification_Code.rds" %in% files) {
    print("The file Source_Classification_Code.rds was found.")
}
if("summarySCC_PM25.rds" %in% files) {
    print("The file summarySCC_PM25.rds was found.")
}    
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore_NEI <- NEI[NEI$fips == "24510",]
totalNEI <- aggregate(Emissions ~ year + type, Baltimore_NEI, sum)

require(ggplot2)

g <- ggplot(totalNEI, aes(year, Emissions, color = type, group = type))
g + geom_point(size = 3) + geom_line()
