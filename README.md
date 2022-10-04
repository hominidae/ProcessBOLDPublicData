# ProcessBOLDPublicData

This repository contains the code written to process DNA barcoding data from the Barcode of Life Datasystem.

## Notes on data sources:

These scripts are looking at data downloaded directly from the BOLD public web interface

Simply go to BOLD Public data portal here: https://www.boldsystems.org/index.php/Public_BINSearch?searchtype=records

Enter a search term like "Nunavut, Canada" and it'll return any matching record with that text anywhere in it.

Once the search has been performed, there are buttons on the right where you can choose to download a Specimens, sequences, or combined as a TSV or tab spaced value text file.

The other data source is from the Global Biodiversity Information Facility. GBIF has data from two sources, some from BOLD and the remainder from iNaturalist.

As part of that, to avoid cross contamination the script removes any data from BOLD within the GBIF data.

## Use of the ggmap Google Maps API

The use of the Google Maps API is free, but you will need to utilize your Google account and enable access.

There is an excellent tutorial available here: https://www.littlemissdata.com/blog/maps

## Step 1: Visit the Google Cloud service page and login
https://console.cloud.google.com 

## Step 2: Add maps static API and get your API key
Follow the instructions for setting up the Maps API on the tutorial

## Step 3: Install the ggmap package and register your API key within R
ggmap::register_google(key = "SET YOUR KEY HERE") <-- That's where your API key goes

## Step 4: Perform mapping with these scripts
From 001 to 003, 
Peruse the 004_MapData.R script to map point data
