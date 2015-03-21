# Load data directly from ZIP:

# First variable:
SMR <- readRDS(unzip("exdata_data_NEI_data.zip","summarySCC_PM25.rds"))

# Second variable:
SCC <- readRDS(unzip("exdata_data_NEI_data.zip","Source_Classification_Code.rds"))

# Create sampling:
SMRS <- SMR[sample(nrow(SMR), size=2000, replace=F), ]

# Aggregate data
EMI <- aggregate(SMR[, 'Emissions'], by=list(SMR$year), FUN=sum)
EMI$PM <- round(EMI[,2]/1000,2)

# Make PNG with plot
png(filename="plot1.png")

barplot(EMI$PM, names.arg=EMI$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()
