files<-dir()
if("Source_Classification_Code.rds" %in% files) {
    print("The file Source_Classification_Code.rds was found.")
}
if("summarySCC_PM25.rds" %in% files) {
    print("The file summarySCC_PM25.rds was found.")
}    
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalNEI <- aggregate(Emissions ~ year, NEI, sum)

with(totalNEI, plot(year, Emissions, type = "b", col = "red", main = "Total emissions per year"))