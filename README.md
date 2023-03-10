# ProcessBOLDPublicData

This code is intended to load BOLD public data using the BOLD Public Data Portal.

### Downloading the BOLD Public Data
[First, go to the BOLD Public Data Portal.](https://www.boldsystems.org/index.php/Public_BINSearch?searchtype=records)

Enter a search term you're interested in, such as a province or territory within quotation marks and hit the search button.

Once you're certain that your search term is right, hit the Combined "TSV" download button to download the data.

WARNING: Depending on the number of specimens in that search, the download could take awhile. Expect it to fail if it's over 1GB.

Just put those downloaded data sets into a "data" directory and change the name for the selected search terms you've used in the "001_FixPublicData.r" file.

You'll need to install Tidyverse using install.packages("tidyverse") command in R or R Studio.
