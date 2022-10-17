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

# Let's write a save so we don't need to do all that again.
write_csv(x = canada_data, "D:/R/InsectsArctic/data/canada_data_october.csv")
write_csv(x = nunavut_data, "D:/R/InsectsArctic/data/nunavut_data_october.csv")

# Let's do some clean-up. We only want canada_data and nunavut_data going forward.
rm(alberta_data,britishcolumbia_data,manitoba_data,newbrunswick_data,newflab_data,novascotia_data,nwt_data,ontario_data,quebec_data,saskatchewan_data,yukon_data)

# Load the GBIF data, this is old data. Is not research grade data.
canadaa_gbif_data <- read_tsv("D:/R/InsectsArctic/Data/Canada_GBIF_data.csv")

# Select from nunavut_data our working set of data
nunavut_specimens <- nunavut_data %>%
  select(recordID,phylum_name,class_name,order_name,family_name,subfamily_name,genus_name,lat,lon)

# Let's map it!
canada_specimens <- canada_data %>%
  select(recordID,phylum_name,class_name,order_name,family_name,subfamily_name,genus_name,lat,lon)

# Let's select data from GBIF too
canada_gbif_specimens <- canada_gbif_data %>%
  select(gbifID,phylum,class,order,family,genus,species,basisOfRecord,stateProvince,decimalLatitude,decimalLongitude)

# Let's select just the "basisOfRecord" column in the canada_gbif_data to see what there is
canada_gbif_records <- canada_gbif_data %>%
  select(basisOfRecord)

# Only keep "HUMAN_OBSERVATION" and others from the "basisOfRecord" column in the canada_gbif_data
canada_gbif_specimens_human <- canada_gbif_specimens %>%
  filter(basisOfRecord == "HUMAN_OBSERVATION")

canada_gbif_specimens_living <- canada_gbif_specimens %>%
  filter(basisOfRecord == "LIVING_SPECIMEN")

canada_gbif_specimens_observation <- canada_gbif_specimens %>%
  filter(basisOfRecord == "OBSERVATION")

canada_gbif_specimens_occurrence <- canada_gbif_specimens %>%
  filter(basisOfRecord == "OCCURRENCE")

# Now join them together.
canada_gbif_specimens_clean1 <- rbind(canada_gbif_specimens_human, canada_gbif_specimens_living)
canada_gbif_specimens_clean2 <- rbind(canada_gbif_specimens_clean1, canada_gbif_specimens_observation)
canada_gbif_specimens_clean3 <- rbind(canada_gbif_specimens_clean2, canada_gbif_specimens_occurrence)
canada_gbif_specimens_clean <- canada_gbif_specimens_clean3
rm(canada_gbif_specimens_clean1,canada_gbif_specimens_clean2,canada_gbif_specimens_clean3)
rm(canada_gbif_specimens_human,canada_gbif_specimens_living,canada_gbif_specimens_observation,canada_gbif_specimens_occurrence)

# Rename gbif clean to gbif specimens
canada_gbif_specimens <- canada_gbif_specimens_clean
rm(canada_gbif_specimens_clean)

# Save our clean GBIF data
write_csv(x = canada_gbif_specimens, "D:/R/InsectsArctic/Data/canada_gbif_data_june.csv")
