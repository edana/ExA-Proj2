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

# Make the selection for Baltimore and LA and merge in one data frame
Baltimore_NEI <- NEI[NEI$fips == "24510",]
LA_NEI <- NEI[NEI$fips == "06037",]
total_Balt_NEI <- aggregate(Emissions ~ year, Baltimore_NEI, sum)
colnames(total_Balt_NEI)[2] <- "Baltimore"
total_LA_NEI <- aggregate(Emissions ~ year, LA_NEI, sum)
colnames(total_LA_NEI)[2] <- "L.A."
total_NEI <- merge(total_Balt_NEI, total_LA_NEI, "year")

#Make the plot
png(file = "plot6.png")
require(ggplot2)
require(reshape2)
g <- ggplot(melt(total_NEI, id.vars = "year") , aes(year, y = value, colour = variable)) 
g + geom_point(size = 3) + geom_line()  + ggtitle("Total emmisions per year")
dev.off()

