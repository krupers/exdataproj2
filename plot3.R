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

# Create sampling:
SMRS <- SMR[sample(nrow(SMR), size=5000, replace=F), ]

# Subset data
YEARS <- subset(SMR, fips=='24510')
YEARS$year <- factor(YEARS$year, levels=c('1999', '2002', '2005', '2008'))

# Make PNG with plot
png(filename="plot3.png")

ggplot(YEARS,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
