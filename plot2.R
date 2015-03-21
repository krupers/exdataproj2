# Load data directly from ZIP:

# First variable:
SMR <- readRDS(unzip("exdata_data_NEI_data.zip","summarySCC_PM25.rds"))

# Second variable:
SCC <- readRDS(unzip("exdata_data_NEI_data.zip","Source_Classification_Code.rds"))

# Create sampling:
SMRS <- SMR[sample(nrow(SMR), size=5000, replace=F), ]

# Subset data
YEARS <- subset(SMR, fips=='24510')

# Make PNG with plot
png(filename="plot2.png")

barplot(tapply(X=YEARS$Emissions, INDEX=YEARS$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()
