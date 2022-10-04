# Load the BOLD data from Canada and the GBIF data
# OBJECTIVE:

# Load libraries
library(tidyverse)

# Load Nunavut data
nunavut_data <- read_tsv("D:/R/InsectsArctic/Data/BOLD_PublicData/012_Nunavut-2022-07-17.txt")

nunavut_specimens <- nunavut_data %>%
  select(recordID,sampleid,bin_uri,fieldnum,sector,phylum_name,class_name,order_name,family_name,subfamily_name,genus_name,lat,lon)

# Only keep insects using match for Arthropoda in Nunauvt
nunavut_arthropoda <- nunavut_specimens %>%
  filter(phylum_name == "Arthropoda")

nunavut_collembola <- nunavut_arthropoda %>%
  filter(class_name == "Collembola")

# Next, we need to filter out CBAY, GJOA, and KUGA from the Collembola data for processing
kugaaruk <- nunavut_collembola %>%
  filter(sector == "Kugaaruk")

gjoahaven <- nunavut_collembola %>%
  filter(sector == "Gjoa Haven")

# Let's repeat what we did for Cambridge Bay and Kugluktuk, but lets do Gjoa Haven and Kugaaruk too!
library(ggVennDiagram)

# Load the processed data from 002_LoadBOLDData.R
camkug <- read_tsv("D:/R/InsectsArctic/Data/camkug.tsv")

# We need to combine camkug with gjoa and kugaaruk

# Straightforward enough. What if we added complexity with Gjoa Haven and Kugaaruk?
# Copy camkug "bin.uri and Sector" to it's own camkug
# Let's call it camkugsimplified
camkugsimplified <- camkug %>%
  select(bin.uri,Sector)
names(camkugsimplified) <- c("bin.uri","Sector")

# Do the same with gjoahaven and kugaaruk
gjoahavenbins <- gjoahaven %>%
  select(bin_uri,sector)

# names(final) <- c("recordID","country_origin","intercept_state")
names(gjoahavenbins) <- c("bin.uri","Sector")
camkuggjoa <- rbind(camkugsimplified,gjoahavenbins)

# Let's do the same with Kugaaruk too!
kugaarukbins <- kugaaruk %>%
  select(bin_uri,sector)
names(kugaarukbins) <- c("bin.uri","Sector")

# Same dealio as before
camkuggjoakuga <- rbind (camkuggjoa,kugaarukbins)

# Before we move on though, let's write camkuggjoakuga as a tsv for later
write_tsv(x = camkuggjoakuga, "D:/R/InsectsArctic/Data/camkuggjoakoga.tsv")

# Let's do a Venn Diagram!
# Assign it to a vector list
x <- camkuggjoakuga %>%
  select(bin.uri,Sector) %>%
  drop_na() %>%
  group_by(Sector) %>%
  nest() %>%
  pull() %>%
  map(unique) %>%
  map(pull)

ggVennDiagram(x, category.names = c("Cambridge Bay","Kugluktuk","Gjoa Haven","Kugaaruk"),
              label_alpha = 0) +
  guides(fill = guide_legend(title = "BINs")) +
  theme(legend.title = element_text(color = "black"),
        legend.position = "right")
