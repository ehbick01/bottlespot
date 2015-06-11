# -----------------------------------------------------------
# Scraping www.bottlespot.com
# 
# Manually do this for the first try, but eventually automate
# -----------------------------------------------------------
library(rvest)

# Build initial dataframe to populate
bottlesComplete <- data.frame()

# Iterate through the 810 pages
for (i in 1:810) {
  
  # Define URL
  url <- paste("http://www.bottle-spot.com/classifieds/all/spirits", "/", i, sep = "")
  url <- html(url)
  
  # Pull names only
  bottleNames <- html_nodes(url, 'listings_area, #div article, #div div, #div, .title')
  bottlesNames <- as.data.frame(html_text(bottleNames))
  bottlesNames <- as.data.frame(bottlesNames[2:21,])

  # Pull description
  bottleDescription <- html_nodes(url, '.blurb')
  bottleDescription <- as.data.frame(html_text(bottleDescription))

  # Pull price
  bottlePrice <- html_nodes(url, '.price')
  bottlePrice <- as.data.frame(html_text(bottlePrice))
  
  # Pull location
  bottleLocation <- html_nodes(url, '.location')
  bottleLocation <- as.data.frame(html_text(bottleLocation))
  
  # Combine all information
  bottles <- cbind(bottlesNames, bottleDescription, bottlePrice, bottleLocation)
  
  # Add to complete dataset
  bottlesComplete <- rbind(bottlesComplete, bottles)
  
}

# Export to csv
bottlesComplete <- write.csv(bottlesComplete, 'bottlesComplete.csv')
