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

# Subset the data for Baltimore
Baltimore_NEI <- NEI[NEI$fips == "24510",]

# Select the emmisions of vehicules for Baltimore
veh_SCC <- SCC[grep("[Vv]eh",SCC$Short.Name),1]
veh_NEI <- NEI[(Baltimore_NEI$SCC %in% veh_SCC),]

totalNEI <- aggregate(Emissions ~ year, veh_NEI, sum)

#Make the plot
png(file = "plot5.png")
require(ggplot2)
g <- ggplot(totalNEI, aes(year, Emissions, colour = "red"))
g + geom_point(size = 3) + geom_line() + theme(legend.position="none") + ggtitle("Motor vehicle related emmisions")
dev.off()
