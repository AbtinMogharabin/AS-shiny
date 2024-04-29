DATA <- eventReactive(input$update11, {
  d3 = read.csv("asylum_seekers_refugee_status.csv", skip = 3, header = T)
  
  for (i in names(d3[-c(2,3,4)])){
    new_i <- c()
    for (j in d3[i]){
      new_i <- c(new_i, as.numeric(j))
    }
    d3[i] <- new_i
  }
  if(is.null(input$CountryofAsylum11) & is.null(input$CountryofOrigin11)){
    subset(d3, (Year>=input$Year11[1] & Year<=input$Year11[2]))
  }else if(is.null(input$CountryofAsylum11)){
    subset(d3, (Origin == input$CountryofOrigin11 & Year>=input$Year11[1] & Year<=input$Year11[2]))
  }else if(is.null(input$CountryofOrigin11)){
    subset(d3, (Country...territory.of.asylum.residence== input$CountryofAsylum11 & Year>=input$Year11[1] & Year<=input$Year11[2]))
  }else{
    d3 <- subset(d3, (Origin == input$CountryofOrigin11 & Year>=input$Year11[1] & Year<=input$Year11[2]))
    subset(d3 ,Country...territory.of.asylum.residence== input$CountryofAsylum11)
  }
})

# Data output
output$tbl11 = renderDataTable({
  DT::datatable(DATA(), options = list(lengthChange = FALSE))
})

summaryfunc <- eventReactive(input$update11, {
  d3 = read.csv("asylum_seekers_refugee_status.csv", skip = 3, header = T)
  
  for (i in names(d3[-c(2,3,4)])){
    new_i <- c()
    for (j in d3[i]){
      new_i <- c(new_i, as.numeric(j))
    }
    d3[i] <- new_i
  }
  d3[as.character(input$checkGroup)]})
#  Summary output 
output$summary11 <- renderPrint({ summary(summaryfunc()) })
