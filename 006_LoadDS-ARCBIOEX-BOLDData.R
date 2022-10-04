# Process data from Museum collections

# Load Libraries
library(tidyverse)
library(dplyr)

# Load dataset
# DS-ARCBIOEX
DS_ARCBIOEX1 <- read_tsv("D:/R/InsectsArctic/Data/DS-ARCBIOEX/collection_data.tsv")
DS_ARCBIOEX5 <- read_tsv("D:/R/InsectsArctic/Data/DS-ARCBIOEX/taxonomy.tsv")
DS_ARCBIOEX7 <- read_tsv("D:/R/InsectsArctic/Data/DS-ARCBIOEX/DS_ARCBIOEX-sequencedata.tsv")

# Filter out Collembola
DS_ARCBIOEX_collembola <- DS_ARCBIOEX5 %>%
  filter(Class == "Collembola")

# Let's combine all that information together
names(DS_ARCBIOEX7) <- c("seq.data","seq.text","process.id","taxon","Sample ID","bin.uri")
test <- inner_join(DS_ARCBIOEX5, DS_ARCBIOEX7, by="Sample ID")
test1 <- inner_join(test, DS_ARCBIOEX1, by="Sample ID")
temp <- data.frame(DS_ARCBIOEX_collembola$"Sample ID")
names(temp) <- c("Sample ID")
test2 <- inner_join(test1, temp, by="Sample ID")

DS_ARCBIOEX_final <- test2
rm(test,test1,test2,temp)

# Unfortunately, it looks like none of those samples are from Nunavut.
# Anyway...
# Write that to a tsv, maybe it'll be useful later.
write_tsv(x = DS_ARCBIOEX_final, "D:/R/InsectsArctic/Data/historic-museum.tsv")