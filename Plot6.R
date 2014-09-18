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
LA_NEI <- NEI[NEI$fips == "06037",]
total_Balt_NEI <- aggregate(Emissions ~ year, Baltimore_NEI, sum)
total_LA_NEI <- aggregate(Emissions ~ year, LA_NEI, sum)

total_NEI <- merge(total_Balt_NEI, total_LA_NEI, "year")

require(ggplot2)

g <- ggplot(total_NEI , aes(year, y = value, colour = variable)) 
g+ geom_point(aes(year, Emissions.x, col = "blue"))
g + geom_point(aes(year, Emissions.y, col = "red"))
