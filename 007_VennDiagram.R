# Generate a combination Venn Diagram

# Load Library
library(tidyverse)
library(ggVennDiagram)

# Load camkuggjoa
camkuggjoakuga <- read_tsv("D:/R/InsectsArctic/Data/camkuggjoakoga.tsv")
historic <- read_tsv("D:/R/InsectsArctic/Data/historic-museum.tsv")

# Simplify historic
historicbins <- historic %>%
  select(bin.uri,Sector)

# We need to do something a little different actually.
# If we select Sector, we have problems.
# Let's select State/Province instead.
historicbins <- historic %>%
  select(bin.uri,'State/Province')

# Now that we have those select, we can include them in the Venn diagram
# The only options for Collembola are:
# Alberta, Northwest Territories, Yukon Territory

# Let's rename the historicbins second column to sector
names(historicbins) <- c('bin.uri','Sector')

# What if we replaced all entries in historicbins with "history"?
# This would eliminate an issue with over representing provinces/territories
historicbins$Sector[historicbins$Sector == "Alberta"] <- "Historic"
historicbins$Sector[historicbins$Sector == "Northwest Territories"] <- "Historic"
historicbins$Sector[historicbins$Sector == "Yukon Territory"] <- "Historic"

# Let's join 'em into their own dataframe
history <- rbind(historicbins, camkuggjoakuga)

# Let's do a Venn Diagram!
# Assign it to a vector list
x <- history %>%
  select(bin.uri,Sector) %>%
  drop_na() %>%
  group_by(Sector) %>%
  nest() %>%
  pull() %>%
  map(unique) %>%
  map(pull)

ggVennDiagram(x, category.names = c("Cambridge Bay","Kugluktuk","Gjoa Haven","Kugaaruk","Alberta","Northwest Territories","Yukon Territory"),
              label_alpha = 0) +
  guides(fill = guide_legend(title = "BINs")) +
  theme(legend.title = element_text(color = "black"),
        legend.position = "right")

# Right that's interesting. But let's de-complicate it a bit.
cambridgebay <- camkuggjoakuga %>%
  filter(Sector == "Cambridge Bay")
cambay_historic <- rbind(historicbins, cambridgebay)

x <- cambay_historic %>%
  select(bin.uri,Sector) %>%
  drop_na() %>%
  group_by(Sector) %>%
  nest() %>%
  pull() %>%
  map(unique) %>%
  map(pull)

# Venn Diagram of just Cambridge Bay and historic specimens
ggVennDiagram(x, category.names = c("Cambridge Bay","Historic"),
              label_alpha = 0) +
  guides(fill = guide_legend(title = "BINs")) +
  theme(legend.title = element_text(color = "black"),
        legend.position = "right")

# Let's do the same with Kugluktuk and historic
kugluktuk <- camkuggjoakuga %>%
  filter(Sector == "Kugluktuk")
kugluk_historic <- rbind(historicbins, kugluktuk)

x <- kugluk_historic %>%
  select(bin.uri,Sector) %>%
  drop_na() %>%
  group_by(Sector) %>%
  nest() %>%
  pull() %>%
  map(unique) %>%
  map(pull)

# Venn Diagram of just Cambridge Bay and historic specimens
ggVennDiagram(x, category.names = c("Kugluktuk","Historic"),
              label_alpha = 0) +
  guides(fill = guide_legend(title = "BINs")) +
  theme(legend.title = element_text(color = "black"),
        legend.position = "right")
