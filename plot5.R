# Install required packages if are not already on PC
required_lib <- c("ggplot2")
install_required_libs <- function() {
  for(i in 1:length(required_lib)) {
    if(required_lib[i] %in% rownames(installed.packages()) == FALSE) {
      install.packages(required_lib[i])
    }
  }
}
install_required_libs()

# Load required libraries for this task
lapply(required_lib,require,character.only=TRUE)


# Load data directly from ZIP:

# First variable:
SMR <- readRDS(unzip("exdata_data_NEI_data.zip","summarySCC_PM25.rds"))

# Second variable:
SCC <- readRDS(unzip("exdata_data_NEI_data.zip","Source_Classification_Code.rds"))

# Make subsets
VEH <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VSCC <- SCC[VEH,]$SCC
VSMR <- SMR[SMR$SCC %in% VSCC,]
BVSMR <- VSMR[VSMR$fips==24510,]


# Make PNG with plot
png(filename="plot5.png")

ggplot(BVSMR,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
