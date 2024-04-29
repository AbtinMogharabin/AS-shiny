submitleaf <- eventReactive(input$button, {
  
  
  
  
  country <- data.frame('country' = sort(unique(d3[[3]])), 'log'=NA, 'lat'= NA, "variable"=NA)
  
  
  map<- read.csv('https://raw.githubusercontent.com/albertyw/avenews/master/old/data/average-latitude-longitude-countries.csv')
  
  for (row in 1:nrow(country)){
    i <- country[row,1]
    if (i %in% map[[2]]){
      m <- subset(map, Country==i)
      country[row,c(2,3)] <- m[c(4,3)]
    }
  }
  
  
  keep <- as.data.frame(rbind(c('Central African Rep.',20.9394,6.6111,NA),
                              c('China, Macao SAR',113.5439,22.1987,NA),
                              c('Iran (Islamic Rep. of)',53.6880,32.4279,NA),
                              c('China, Hong Kong SAR',114.1694,22.3193,NA),
                              c('Rep. of Korea',127.7669,35.9078,NA),
                              c('Rep. of Moldova',28.3699,47.4116,NA),
                              c('South Sudan',31.3070,6.8770,NA),
                              c('Viet Nam',108.2772,14.0583,NA),
                              c('United States of America',-95.7129,37.0902,NA)))
  names(keep) <- names(country)
  
  country <- as.data.frame(rbind(country,keep))
  
  country[4] <- 1
  
  country <- na.omit(country)
  
  country <- country[order(country$country),]
  
  
  
  
  country <- data.frame(Country=country$country, log=country$log,lat=country$lat, variable=NA)
  
  for (i in names(country[-1])){
    new_i <- c()
    for (j in country[i]){
      new_i <- c(new_i, as.numeric(j))
    }
    country[i] <- new_i
  }
  
  subset(country, Country==input$country1)
  
  
  
  d3new <- subset(d3, Origin==input$country1 & Year == input$year1)
  
  for (i in input$country1){
    m <- sum(subset(d3new, Origin==i)[[input$num_var]],na.rm=T)#####issue
    for (j in 1:nrow(country)){
      if(country[j,1]==i){
        country[j,4] <- m
      }
    }
  }
  leafdata <- na.omit(country)
  
  
  
  ##
  leafdata %>% 
    leaflet() %>%
    addTiles() %>%
    addCircles(~log, ~lat, 
               weight = 10,
               radius = 120,
               popup = paste0(
                 "<b>Country: </b>", 
                 leafdata$Country,
                 "<br>",
                 "<b> Year : </b>",
                 input$year1,
                 "<br>",
                 paste0("<b>Total of (",input$num_var,") : </b>"),
                 leafdata[[4]])
               
    ) %>% 
    setView(lng = median(leafdata$log),
            lat = median(leafdata$lat),
            zoom =2.5)
  
})

output$mymap <- renderLeaflet(submitleaf())