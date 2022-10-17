# Process BOLD and GBIF data from Canada
# OBJECTIVE:
#  - Load data from every province/territory in Canada from BOLD public data
#  - Load data from GBIF from Canada, iNaturalist observations
#  - Sort out the records from GBIF that aren't preserved specimens (AKA already in BOLD)

# Load library
library(tidyverse)

# Load the Public BOLD data sets. Searched by Province/Territory
britishcolumbia_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/001_British_Columbia_2022_10_11.txt")
alberta_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/002_Alberta_October_11_2022.txt")
saskatchewan_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/003_Saskatchewan_2022_10_11.txt")
manitoba_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/004_Manitoba_2022_10_11.txt")
ontario_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/005_Ontario_2022_10_15.txt")
quebec_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/006_Quebec_2022_10_14.txt")
newbrunswick_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/007_NewBrunswick_2022_10_14.txt")
novascotia_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/008_Nova_Scotia_2022_10_15.txt")
newflab_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/009_Newfoundland_Labradour_2022_10_15.txt")
yukon_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/010_Yukon_2022_10_15.txt")
nwt_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/011_NWT_2022_10_15.txt")
nunavut_data <- read_tsv("D:/R/ProcessBOLDPublicData/data/012_Nunavut_2022_10_15.txt")

# Combine them all into one data set
canada_data <- rbind(britishcolumbia_data, alberta_data)
canada_data1 <- rbind(canada_data, saskatchewan_data)
canada_data2 <- rbind(canada_data1, manitoba_data)
canada_data3 <- rbind(canada_data2, ontario_data)
canada_data4 <- rbind(canada_data3, quebec_data)
canada_data5 <- rbind(canada_data4, newbrunswick_data)
canada_data6 <- rbind(canada_data5, novascotia_data)
canada_data7 <- rbind(canada_data6, newflab_data)
canada_data8 <- rbind(canada_data7, yukon_data)
canada_data9 <- rbind(canada_data8, nwt_data)
canada_data10 <- rbind(canada_data9, nunavut_data)
rm(canada_data1,canada_data2,canada_data3,canada_data4,canada_data5,canada_data6,canada_data7,canada_data8,canada_data9)
canada_data <- canada_data10
rm(canada_data10)

# Let's do some clean-up. We only want canada_data and nunavut_data going forward.
rm(alberta_data,britishcolumbia_data,manitoba_data,newbrunswick_data,newflab_data,novascotia_data,nwt_data,ontario_data,quebec_data,saskatchewan_data,yukon_data)

# Let's write a save so we don't need to do all that again.
write_csv(x = canada_data, "D:/R/InsectsArctic/data/canada_data_october.csv")
write_csv(x = nunavut_data, "D:/R/InsectsArctic/data/nunavut_data_october.csv")
