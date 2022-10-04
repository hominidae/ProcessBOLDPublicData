# Process DNA sequencing data from Museum Samples

# Load libraries
library(phylotools)
library(tidyverse)
library(stringr)

# Load sequencing data using read.FASTA
DS_ARCBIOEX_sequencedata <- read.fasta(file = "D:/R/InsectsArctic/Data/DS-ARCBIOEX/SequenceData.fas")

# Now that it's loaded, we have an interesting problem.
# We need to separate out the data into their own fields.
# To do that, we're going to use str_extract.

# We need to separate out the following into their own columns.
# Here is what the data inside the first column of dataset looks like:
# ACHAR1776-18|Psammitis deichmanni|CHARS00069-C01|BOLD:AAB7094
# ACHAR1776-18
# Psammitis deichmanni
# CHARS500069-C01
# BOLD:AAB7094

# First, copy the seq.name column to x temporarily
x <- DS_ARCBIOEX_sequencedata$seq.name

# Next, let's use str_split to take the x list and split it by the | character
y <- x %>%
  str_split("\\|")

# Now that we have that, let's use a simple solution to turn the data from being wide to being tall instead when we turn it into a data frame
DS_ARCBIOEX_splitdata <- data.frame(Reduce(rbind, y))

DS_ARCBIOEX_expanded <- data.frame(DS_ARCBIOEX_sequencedata$seq.text,DS_ARCBIOEX_sequencedata$seq.name,DS_ARCBIOEX_splitdata$X1,DS_ARCBIOEX_splitdata$X2,DS_ARCBIOEX_splitdata$X3,DS_ARCBIOEX_splitdata$X4)

# Great! Now that that's done, let's rename all the columns
names(DS_ARCBIOEX_expanded) <- c("seq.data","seq.text","process.id","taxon","sample.id","bin.uri")

# Next up, we need replace blank entries for BIN URI's with NA's
# Why? Because we're classy like that.
DS_ARCBIOEX_expanded_na <- DS_ARCBIOEX_expanded %>%
  mutate_all(na_if,"")

# Fabulous. Now that we have the sequencing data sorted let's do some cool shit.
# That's it for this script. But before we go, let's save our work.
write_tsv(x = DS_ARCBIOEX_expanded_na, "D:/R/InsectsArctic/Data/DS-ARCBIOEX/DS_ARCBIOEX-sequencedata.tsv")

# Let's clean up our workspace.
rm(x,y,DS_ARCBIOEX_sequencedata,DS_ARCBIOEX_splitdata,DS_ARCBIOEX_expanded,DS_ARCBIOEX_expanded_na)
