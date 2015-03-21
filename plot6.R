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
VBSMR <- VSMR[VSMR$fips == 24510,]
VBSMR$city <- "Baltimore City"
VLA <- VSMR[VSMR$fips=="06037",]
VLA$city <- "Los Angeles County"
SMRall <- rbind(VBSMR,VLA)

# Make PNG with plot
png(filename="plot6.png")

ggplot(SMRall, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
