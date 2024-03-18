formulaText <- function(){
  
  
  paste(input$select2,"~", input$select1)
}



# Return the formula text for printing as a caption ----
output$caption <- renderText({
  d3 <- na.omit(d3)
  formulaText()
})




output$myplot <- renderPlot({
  d3 = read.csv("asylum_seekers_refugee_status.csv", skip = 3, header = T)
  
  for (i in names(d3[-c(2,3,4)])){
    new_i <- c()
    for (j in d3[i]){
      new_i <- c(new_i, as.numeric(j))
    }
    d3[i] <- new_i
  }
  plot <- function(d3){
    
    
    d3[1] <- as.character.default(d3[[1]])
    
    if(input$select1=='Year'){
      
      
      if(input$face == 'Country...territory.of.asylum.residence'){
        
        d3 <- subset(d3, Country...territory.of.asylum.residence==input$countries)
        
      }else if(input$face == 'Origin'){
        
        d3 <- subset(d3, Origin==input$countries)
        
      }
      
      violin <- ifelse(input$violin, yes = '+geom_violin(alpha=0.3)', no = '')
      j <- paste0('+geom_jitter',"(size=",input$size, ",",input$color)
      jitter <- ifelse(input$jitter, yes = j, no='')
      lognomial <- ifelse(input$lognomial, yes = '+scale_y_log10()', no='')
      linearR <- ifelse(input$checkbox, yes = '+stat_summary(geom = "line", fun = mean, group = 1, size=1.5, color="dark red")', no = '')
      facet <- ifelse((input$face != '' & input$select1 != input$face), yes = paste0("+facet_wrap(~",input$face,")"), no = '')
      subdata <- subset(d3, (Year>=input$slider1[1] & Year<=input$slider1[2]))
      box <- ifelse(input$boxplot, yes = '+geom_boxplot(alpha=0.3)' ,no ='')
      
      t <- paste0('ggplot(data = subdata, mapping=aes_string(input$select1,input$select2))+
        geom_point',"(size=",input$size, ",",input$color,'+
        theme(axis.text.x = element_text(angle = 40, hjust = 1, size=13))',input$theme,
                  facet, jitter,linearR,violin, lognomial, box)
      eval(parse(text=t))
      
    }
    
    
    
    
    
    else if(input$select1=='Country...territory.of.asylum.residence' | input$select1=='Origin'){
      
      
      violin <- ifelse(input$violin, yes = '+geom_violin(alpha=0.3)', no = '')
      j <- paste0('+geom_jitter',"(size=",input$size, ",",input$color)
      jitter <- ifelse(input$jitter, yes = j, no='')
      box <- ifelse(input$boxplot, yes = '+geom_boxplot(alpha=0.3)' ,no ='')
      lognomial <- ifelse(input$lognomial, yes = '+scale_y_log10()', no='')
      linearR <- ifelse(input$checkbox, yes = '+stat_summary(geom = "line", fun = mean, group = 1, size = 1.5, color="dark red")', no = '')
      facet <- ifelse(input$face == 'Year', yes = paste0("+facet_wrap(~Year)"), no = '')
      d3 <- subset(d3, (Year>=input$slider1[1] & Year<=input$slider1[2]))
      
      d3 <- subset(d3, eval(parse(text=input$select1))==input$countries)
      
      
      t <- paste0('ggplot(data = d3, mapping=aes_string(input$select1,input$select2))+
        geom_point',"(size=",input$size, ",",input$color,'+
        theme(axis.text.x = element_text(angle = 40, hjust = 1, size=13))',input$theme,
                  facet, jitter,linearR, violin,lognomial,box)
      eval(parse(text=t))}
  }
  f <- function(d3){
    d3 <- d3[order(d3[input$select2], decreasing = TRUE),]
    top5p <- as.integer(0.01*(dim(d3)[1]))
    max <- dim(d3)[1]
    d3_new <- d3[top5p:max,]
    plot(d3_new)
  }
  if(input$outlier){
    if(input$select1=="Year"){
      f(d3)
    }else{
      
      d3 <- subset(d3, eval(parse(text=input$select1))==input$countries)
      
      f(d3)
    }
    
  }else{
    plot(d3)
  }
}
)




select_plot <- function(){
  d3 = read.csv("asylum_seekers_refugee_status.csv", skip = 3, header = T)
  
  for (i in names(d3[-c(2,3,4)])){
    new_i <- c()
    for (j in d3[i]){
      new_i <- c(new_i, as.numeric(j))
    }
    d3[i] <- new_i
  }
  plot <- function(d3){
    
    
    if(input$select1=='Year'){
      
      
      if(input$face == 'Country...territory.of.asylum.residence'){
        
        d3 <- subset(d3, Country...territory.of.asylum.residence==input$countries)
        
      }else if(input$face == 'Origin'){
        
        d3 <- subset(d3, Origin==input$countries)
        
      }
      
      violin <- ifelse(input$violin, yes = '+geom_violin(alpha=0.3)', no = '')
      j <- paste0('+geom_jitter',"(size=",input$size, ",",input$color)
      jitter <- ifelse(input$jitter, yes = j, no='')
      lognomial <- ifelse(input$lognomial, yes = '+scale_x_log10()+scale_y_log10()', no='')
      linearR <- ifelse(input$checkbox, yes = '+stat_summary(geom = "line", fun = mean, group = 1, size=1.5, color="dark red")', no = '')
      facet <- ifelse((input$face != '' & input$select1 != input$face), yes = paste0("+facet_wrap(~",input$face,")"), no = '')
      subdata <- subset(d3, (Year>=input$slider1[1] & Year<=input$slider1[2]))
      box <- ifelse(input$boxplot, yes = '+geom_boxplot(alpha=0.3)' ,no ='')
      
      title <- paste(input$select2,"~", input$select1)
      
      
      t <- paste0('ggplot(data = subdata, mapping=aes_string(input$select1,input$select2))+
        geom_point',"(size=",input$size, ",",input$color,'+
        theme(axis.text.x = element_text(angle = 40, hjust = 1, size=13))',input$theme,
                  facet, jitter,linearR, violin, lognomial,box,'+
                      labs(title = "',title,'",
                            caption ="Downloded from Pied Piper shiny app")')
      eval(parse(text=t))
      
    }
    
    
    
    
    
    
    else if(input$select1=='Country...territory.of.asylum.residence' | input$select1=='Origin'){
      
      
      violin <- ifelse(input$violin, yes = '+geom_violin(alpha=0.3)', no = '')
      j <- paste0('+geom_jitter',"(size=",input$size, ",",input$color)
      jitter <- ifelse(input$jitter, yes = j, no='')
      box <- ifelse(input$boxplot, yes = '+geom_boxplot(alpha=0.3)' ,no ='')
      lognomial <- ifelse(input$lognomial, yes = '+scale_y_log10()', no='')
      linearR <- ifelse(input$checkbox, yes = '+stat_summary(geom = "line", fun = mean, group = 1, size=1.5, color="dark red")', no = '')
      facet <- ifelse(input$face == 'Year', yes = paste0("+facet_wrap(~Year)"), no = '')
      d3 <- subset(d3, (Year>=input$slider1[1] & Year<=input$slider1[2]))
      
      d3 <- subset(d3, eval(parse(text=input$select1))==input$countries)
      
      
      title <- paste(input$select2,"~", input$select1)
      
      
      t <- paste0('ggplot(data = d3, mapping=aes_string(input$select1,input$select2))+
        geom_point',"(size=",input$size, ",",input$color,'+
        theme(axis.text.x = element_text(angle = 40, hjust = 1, size=13))',input$theme,
                  facet, jitter, linearR,violin, lognomial,box,'+
                      labs(title = "',title,'",
                            caption ="Downloded from Pied Piper shiny app")')
      eval(parse(text=t))}
  }
  f <- function(d3){
    d3 <- d3[order(d3[input$select2], decreasing = TRUE),]
    top5p <- as.integer(0.01*(dim(d3)[1]))
    max <- dim(d3)[1]
    d3_new <- d3[top5p:max,]
    plot(d3_new)
  }
  if(input$outlier){
    if(input$select1=="Year"){
      f(d3)
    }else{
      
      d3 <- subset(d3, eval(parse(text=input$select1))==input$countries)
      
      f(d3)
    }
    
  }else{
    plot(d3)
  }
  
}

output$downloader <- downloadHandler(
  filename = paste0("MyPlot-",Sys.Date(),'.png') ,
  content = function(file) {
    device <- function(..., width, height) grDevices::png(..., width = 1500, height = 884)
    ggsave(file, plot = select_plot(), device = device)
    
  }
)