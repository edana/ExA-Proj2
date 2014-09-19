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

# Calculate the total emission for Baltimore
Baltimore_NEI <- NEI[NEI$fips == "24510",]
totalNEI <- aggregate(Emissions ~ year, Baltimore_NEI, sum)

#Make the plot
png(file = "plot2.png")
with(totalNEI, plot(year, Emissions, type = "b", col = "red", main = "Total emissions per year in Baltimore"))
dev.off()