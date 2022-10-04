# ProcessBOLDPublicData

This repository contains the code written to process DNA barcoding data from the Barcode of Life Datasystem.

## Use of the ggmap Google Maps API

The use of the Google Maps API is free, but you will need to utilize your Google account and enable access.

There is an excellent tutorial available here: https://www.littlemissdata.com/blog/maps

## Step 1: Visit the Google Cloud service page and login
https://console.cloud.google.com 

## Step 2: Add maps static API and get your API key
Follow the instructions for setting up the Maps API on the tutorial

## Step 3: Install the ggmap package and register your API key within R
ggmap::register_google(key = "SET YOUR KEY HERE") <-- That's where your API key goes

## Step 4: Peruse the 004_MapData.R script to map point data
