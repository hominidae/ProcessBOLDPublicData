# Map data
# OBJECTIVE:
#  - Map the data

# Load libraries
library(tidyverse)
library(ggmap)

# Load the data
nunavut_arthropoda <- read_csv("D:/R/InsectsArctic/Data/nunavut_arthropoda_june.csv")
canada_arthropoda <- read_csv("D:/R/InsectsArctic/Data/canada_arthropoda_june.csv")
canada_gbif_arthropoda <- read_csv("D:/R/InsectsArctic/Data/canada_gbif_arthropoda_june.csv")

# Remove NA's from Nunavut arthropoda
latnotdistinctarth <- data.frame(nunavut_arthropoda$lat)
latnotdistinctarth <- latnotdistinctarth[!is.na(latnotdistinctarth)]
longnotdistinctarth <- data.frame(nunavut_arthropoda$lon)
longnotdistinctarth <- longnotdistinctarth[!is.na(longnotdistinctarth)]

# Remove NA's from Canada arthropoda
latcannotdistinctarth <- data.frame(canada_arthropoda$lat)
latcannotdistinctarth <- latcannotdistinctarth[!is.na(latcannotdistinctarth)]
longcannotdistinctarth <- data.frame(canada_arthropoda$lon)
longcannotdistinctarth <- longcannotdistinctarth[!is.na(longcannotdistinctarth)]

# Remove NA's from Insecta from GBIF's Canada data
latcangbifnotdistinctarth <- data.frame(canada_gbif_arthropoda$lat)
latcangbifnotdistinctarth <- latcangbifnotdistinctarth[!is.na(latcangbifnotdistinctarth)]
longcangbifnotdistinctarth <- data.frame(canada_gbif_arthropoda$lon)
longcangbifnotdistinctarth <- longcangbifnotdistinctarth[!is.na(longcangbifnotdistinctarth)]

# Populate only Arthropoda collected in Nunavut
mapnuarth.x <- longnotdistinctarth
mapnuarth.y <- latnotdistinctarth

# Populate only Arthropoda collected in Canada
mapcanarth.x <- longcannotdistinctarth
mapcanarth.y <- latcannotdistinctarth

# Populate only Insecta collected in Canada GBIF
mapcangbifarth.x <- longcangbifnotdistinctarth
mapcangbifarth.y <- latcangbifnotdistinctarth

# Redraw with just Arthropoda
mapnuarth.x <- longnotdistinctarth
mapnuarth.y <- latnotdistinctarth
mp <- mp+ geom_point(aes(x=mapnuarth.x, y=mapnuarth.y), color="green", size=1)
mp

# Let's try something else, using the Google Maps API
# Set centre of map to centre of Canada
# 49.77152683630754, -96.81643342186659
# Alternative, centre on the arctic
# 65.37890150264174, -103.89915490418755
# Alt, cambridge bay
# 69.11673387824136, -105.06173296903886
can_centre <- c(long = -105.061732, lat = 69.116733)
# Retrieve map of Canada from Google Maps
mapcan <- get_googlemap(center = can_centre, zoom = 3, maptype="terrain")

######################### This is for Nunavut
# Unfortunately, we need a dataframe rather than vector lists
# So let's fix that
nu_arth <- data.frame(latnotdistinctarth,longnotdistinctarth)
# Change the column names
names(nu_arth) <- c("lat", "long")

ggmap(mapcan) +
  geom_point(
    data = nu_arth,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)

###################### This is for all of Canada BOLD data
can_arth <- data.frame(latcannotdistinctarth,longcannotdistinctarth)
# Change the column names
names(can_arth) <- c("lat", "long")

# Map with ggmap and Google Maps API
ggmap(mapcan) +
  geom_point(
    data = can_arth,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)
 
# This is for observations from GBIF
can_gbif_arth <- data.frame(latcangbifnotdistinctarth,longcangbifnotdistinctarth)
# Change the column names
names(can_gbif_arth) <- c("lat", "long")

# Map with ggmap and Google Maps API
ggmap(mapcan) +
  geom_point(
    data = can_gbif_arth,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)

# Let's try a heatmap
library(RColorBrewer)

# This is for Nunavut insects
ggmap(mapcan) +
  stat_density_2d(
    data = nu_arth,
    aes(
      x = long,
      y = lat,
      fill = stat(level)
    ),
    alpha = .2,
    bins = 25,
    geom = "polygon"
  ) +
  scale_fill_gradientn(colors = brewer.pal(7, "YlOrRd"))

######################### The same code as above, but for Canada insects
ggmap(mapcan) +
  stat_density_2d(
    data = can_arth,
    aes(
      x = long,
      y = lat,
      fill = stat(level)
    ),
    alpha = .5,
    bins = 75,
    geom = "polygon"
  ) +
  scale_fill_gradientn(colors = brewer.pal(7, "YlOrRd"))

######################### The same code as above, but for Canada GBIF insects
can_gbif_arth <- data.frame(latcangbifnotdistinctarth,longcangbifnotdistinctarth)
# Change the column names
names(can_gbif_arth) <- c("lat", "long")

ggmap(mapcan) +
  stat_density_2d(
    data = can_gbif_arth,
    aes(
      x = long,
      y = lat,
      fill = stat(level)
    ),
    alpha = .5,
    bins = 75,
    geom = "polygon"
  ) +
  scale_fill_gradientn(colors = brewer.pal(7, "YlOrRd"))

# Right, now let's map just points for collembola
nunavut_collembola <- nunavut_arthropoda %>%
  filter(class_name == "Collembola")

# Same for Canada BOLD data
canada_collembola <- canada_arthropoda %>%
  filter(class_name == "Collembola")

# Same for Canada GBIF data
canada_gbif_collembola <- canada_gbif_arthropoda %>%
  filter(class_name == "Collembola")

# Filter out NA's from Nunavut Collembola
latnotdistinctcoll <- data.frame(nunavut_collembola$lat)
latnotdistinctcoll <- latnotdistinctcoll[!is.na(latnotdistinctcoll)]
longnotdistinctcoll <- data.frame(nunavut_collembola$lon)
longnotdistinctcoll <- longnotdistinctcoll[!is.na(longnotdistinctcoll)]

# Filter out NA's from Canada COllembola
latcannotdistinctcoll <- data.frame(canada_collembola$lat)
latcannotdistinctcoll <- latcannotdistinctcoll[!is.na(latcannotdistinctcoll)]
longcannotdistinctcoll <- data.frame(canada_collembola$lon)
longcannotdistinctcoll <- longcannotdistinctcoll[!is.na(longcannotdistinctcoll)]

# Filter out NA's from Canada GBIF Collembola
latcangbifnotdistinctcoll <- data.frame(canada_gbif_collembola$lat)
latcangbifnotdistinctcoll <- latcangbifnotdistinctcoll[!is.na(latcangbifnotdistinctcoll)]
longcangbifnotdistinctcoll <- data.frame(canada_gbif_collembola$lon)
longcangbifnotdistinctcoll <- longcangbifnotdistinctcoll[!is.na(longcangbifnotdistinctcoll)]

# Great, no let's map them to coords
# Populate only Arthropoda collected in Nunavut
mapnucoll.x <- longnotdistinctcoll
mapnucoll.y <- latnotdistinctcoll

# Populate only Arthropoda collected in Canada
mapcancoll.x <- longcannotdistinctcoll
mapcancoll.y <- latcannotdistinctcoll

# Populate only Insecta collected in Canada GBIF
mapcangbifcoll.x <- longcangbifnotdistinctcoll
mapcangbifcoll.y <- latcangbifnotdistinctcoll

# Load coords for Nunavut
nu_coll <- data.frame(latnotdistinctcoll,longnotdistinctcoll)
# Change the column names
names(nu_coll) <- c("lat", "long")

# Map it
ggmap(mapcan) +
  geom_point(
    data = nu_coll,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)

# Let's do the same for Canada
###################### This is for all of Canada BOLD data
can_coll <- data.frame(latcannotdistinctcoll,longcannotdistinctcoll)

# Change the column names
names(can_coll) <- c("lat", "long")

# Map with ggmap and Google Maps API
ggmap(mapcan) +
  geom_point(
    data = can_coll,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)

# Let's do the same for Canada GBIF data
can_gbif_coll <- data.frame(latcangbifnotdistinctcoll,longcangbifnotdistinctcoll)

# Change the names
names(can_gbif_coll) <- c("lat", "long")

# Map it! 
ggmap(mapcan) +
  geom_point(
    data = can_gbif_coll,
    mapping = aes(
      x = long,
      y = lat),
    color="red",
    size=5,
    alpha = 0.01)
