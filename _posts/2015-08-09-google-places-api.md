---
layout: post
title: "Finding a cash machine with the Google Places API "
comments: true
date: "Sunday, August 9, 2015"
featured_image: /images/hdf.gif
tags:
- Data Science
excerpt:
---

Trying to find a free cash machine is one of the great challenges faced by Londoners, up there with getting a pint for less than £4 and renting a property close to the center without having to live on bread and water for the rest of the year. Unfortunately web technology has been a bit tardy in coming up with a solution; there are some of independent web apps from different [machine](http://www.visa.com/atmlocator/index.jsp) [companies](http://www.link.co.uk/ATMLocator/Pages/ATMLocator.aspx), and a couple of apps on the google app store with [mixed](https://play.google.com/store/apps/details?id=com.moneypass&hl=en) [reviews](https://play.google.com/store/apps/details?id=com.souf.nearbyATM&hl=en), and that's about it.

Whilst doing a project at work recently I discovered the [Google places API](https://developers.google.com/places/?hl=en), which provides an interface to Google Maps' huge database of places around the globe. You can search for nearby places given a position, and filter by different place types, including _atm's_. It doesn't differentiate between surcharge free API's, or those inside Bank's, but it also doesn't discriminate between ATM type; not perfect, but a start.

Below is a brief R script for producing a plot of the nearest ATM's given a postcode. The google places API gives you 1000 requests per day, but if you enter your billing details you get up to 150000 (it won't charge you, the details are only required to verify your identity).

The `rjson` library is used throughout for grabbing API data.  

```r
library(rjson)
```

Below I query the google maps API for latitude and longitude coordinates given a postocde, in this case the [old lady](http://www.historic-uk.com/CultureUK/The-Old-Lady-of-Threadneedle-Street/) in the heart of the city. I construct the API request string, grab the JSON, test whether the look up was succesful, then assign the longitude and latitude data to variables with less verbose names.

```r
postcode = "EC2R8AH"

API_request <- "https://maps.googleapis.com/maps/api/geocode/json?address="
API_request <- paste(API_request,postcode,sep="")

address <- rjson::fromJSON(file=API_request)

if(address$status != "OK"){
  stop("Error in API look up")
}

latitude <- address$results[[1]]$geometry$location$lat
longitude <- address$results[[1]]$geometry$location$lng
```

We're now ready to query the places API. If you've verified your identity, you will be given a key which needs to be passed in the look up. If not, leave it as `NULL` and it'll be left our of your query string later.

```r
key = "..."
```

There are a number of different searches in the places API you can employ, detailed [here](https://developers.google.com/places/webservice/search). I use the *nearby search*, which requires location coordinates and a radius within which to search. These are provided as ampersand separated arguments at the end of the URL. You can also specify whether to rank your results based on distance from your location. Finally, we add a *type* which we wish to return, _atm_. This will return the 20 nearest atm's ranked by distance.

```r
API_request <- "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=2000&rankby=distance&types=atm"

if(!is.null(key)){
  API_request <- paste(API_request,paste("&key=",key,sep=""),sep="")
}

API_request <- paste(API_request,"&location=", paste(latitude,longitude,sep=","),sep="")

bank_address <- rjson::fromJSON(file = API_request, unexpected.escape = "keep")

if(bank_address$status != "OK"){
  stop("Error in API look up")
}
```

To make the data easier to work with I use the `data.table` packages `rbindlist` function to flatten some key variables in the JSON in to a data table.

```r
library(data.table)

bank.details <- rbindlist(lapply(bank_address$results, function(x) data.frame(as.numeric(x$geometry$location$lat[[1]]),
                                                                                 as.numeric(x$geometry$location$lng[[1]]),
                                                                                 as.character(x$name[[1]]),
                                                                                 as.character(x$vicinity[[1]]))))

setnames(bank.details, c("Latitude","Longitude","Name","Address"))
```

To plot the results I use the `ggmap` package, grabbing a map centered on the location provided at the start, with each ATM highlighted by a different colour.

```r
library(ggmap)

map <- get_map(location = c(longitude,latitude), zoom = 14, maptype = "roadmap", scale = 2)

ggmap(map) +
  geom_point(data = bank.details, aes(x = Longitude, y = Latitude, colour = Name),
             size = 8, alpha = 0.3, shape = 19)
```

<center>![branches](/images/branches.png "Nearest atm's to Bank")</center>
