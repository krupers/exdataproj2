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


# Merge datasets
CBR <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
CLR <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
CLC <- (CBR & CLR)
CSCC <- SCC[CLC,]$SCC
CSMR <- SMR[SMR$SCC %in% CSCC,]

# Make PNG with plot
png(filename="plot4.png")

ggplot(CSMR,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()
