# Process all data from Nunavut

# Load library
library(tidyverse)

# Load DNA Barcoding data from Canada from BOLD
nunavut_data <- read_tsv("D:/R/InsectsArctic/Data/012_Nunavut-UPDATED.txt")


############################# This entire script is a bit wonky atm. Fix later.

# Updated Nunavut data analysis
nunavut_specimens <- nunavut_data %>%
  select(recordID,bin_uri,phylum_name,class_name,order_name,family_name,subfamily_name,genus_name,lat,lon)

# Let's look at it
table(nunavut_specimens$phylum_name)
table(nunavut_specimens$class_name)
table(nunavut_specimens$order_name)
table(nunavut_specimens$family_name)
table(nunavut_specimens$subfamily_name)
table(nunavut_specimens$genus_name)

# Alright, let's separate out arthopoda.
nunavut_arthropoda <- nunavut_specimens %>%
  filter(phylum_name == "Arthropoda")

# Let's use complete cases to simplify our work to COMPLETE DATA
nunavut_arthropoda[complete.cases(nunavut_arthropoda), ] # Keep only the complete rows
data_complete <- nunavut_arthropoda[complete.cases(nunavut_arthropoda), ] # Store the complete cases subset in a new data frame

# That reduces all records from Nunavut from 76k to 38k. So stripped a lot of incomplete data. We'll do selective removal later.
# But for now, let's focus on what matters. Let's get a table of what we have
table(data_complete$class_name)
# We have:
# 37633 Insecta
#   374 Collembola
#   369 Arachnida
#   177 Copepoda
#    63 Malacostraca
#    22 Branchipoda
#    15 Ostracoda
#    13 Thecostraca

# But for now, let's limit our selection to Cambridge Bay, Kugluktuk, Gjoa Haven, and Kugaaruk

# Let's remove any GPS coordinates that don't match our communities.
# 67.82, -115.10 Kugluktuk
# 69.11, -105.06 Cambridge Bay
# 68.63, -95.84 Gjoa Haven
# 68.53, -89.81 Kugaaruk

# Let's see if we can only retain records with 67,69,68 for latitude in data_complete
# To do that, we're going to use filter()
testme <- filter(data_complete, lat > 67.0)
testme1 <- filter(testme, lat < 69.25)

# Let's do the same with longitude
testme2 <- filter(testme1, lon > -116)
testme3 <- filter(testme2, lon < -88)

# Hmm, that didn't quite do what we wanted. There are points in between that are covered by other collections.
