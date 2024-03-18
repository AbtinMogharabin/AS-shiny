tabPanel('Data Visualization', icon = icon("chart-bar"),
         sidebarLayout(
           sidebarPanel(
             titlePanel("Customize your plot:")
             ,
             # Application title
             tabPanel("my plot", width = 2,
                      selectInput("select1", label = h3("Select x-axis"), 
                                  choices = list("Year"='Year'                                
                                                 ,"Country/Territory of asylum residence"='Country...territory.of.asylum.residence'
                                                 ,"Country of origin"='Origin'), 
                                  selected = 1),
                      selectInput("select2", label = h3("Select y-axis"), 
                                  choices = list("Total people pending at the start of the year" = "Total.persons.pending.start.year",
                                                 "People UNHCR assisted " = "of.which.UNHCR.assisted ",
                                                 "People who applied during the year" = "Applied.during.year",
                                                 "Decision recognized" = "statistics.filter.decisions_recognized",
                                                 "Filter decision other" = "statistics.filter.decisions_other",
                                                 "Rejected" = "Rejected",
                                                 "Otherwise closed " = "Otherwise.closed ",
                                                 "Total decisions" = "Total.decisions ",
                                                 "Total pending at the end of year" = "Total.persons.pending.end.year",
                                                 "Of which UNHCR assisted" = "of.which.UNHCR.assisted.1"), 
                                  selected = 1),
                      selectizeInput('countries',
                                     label="Choose up to 6 countries to show (if available):",
                                     choices=sort(unique(c(d3[[2]],d3[[3]]))),
                                     selected = c("Turkey","South Africa","Ukraine","United States of America"),
                                     multiple = TRUE,
                                     options = list(maxItems = 6)
                      ),
                      
                      sliderInput("size", label = h3("Size of point characters:"),
                                  min = 0.1, max = 8, value = 1.5),
                      
                      sliderInput("slider1", label = h3("Year Range:"), min = 2000, 
                                  max = 2014, value = c(2008, 2012), sep = ""),
                      
                      selectInput("face", label = h3("facet_wrap"),
                                  choices = list('-'='',
                                                 "Year"='Year'                                
                                                 ,"Country/Territory.of.asylum.residence"='Country...territory.of.asylum.residence'
                                                 ,"Country of origin"='Origin' )),
                      
                      p('Note: "Country of Origin" and "Country/Territory of asylum residence" facet_wraps only activates when your x-axis is selected as "Year".'),
                      
                      selectInput("color", label = h3("Choose the color"), 
                                  choices = list("black"='color="black")'      
                                                 ,"red"='color="red")'     
                                                 ,"dark red"='color="dark red")'
                                                 ,"blue"='color="blue")'                  
                                                 ,"yellow"='color="yellow")' 
                                                 ,"purple"='color="purple")'     
                                                 ,'green'='color="green")'
                                                 ,'dark green'='color="dark green")'
                                                 ,"pink"='color="pink")'
                                                 ,"white"='color="white")'
                                  )),
                      
                      selectInput("theme", label = h3("Change the theme"), 
                                  choices = list('Original theme'='',
                                                 'classic'='+theme_classic()'
                                                 ,'economist'='+theme_economist()'
                                                 ,'stata'='+theme_stata()'
                                                 ,'base'='+theme_base()'
                                                 ,'dark'='+theme_dark()'
                                                 ,'get'='+theme_get()'),
                                  selected=1),
                      
                      
                      
                      
                      
                      titlePanel("Extra modifications:"),
                      
                      checkboxInput("boxplot", label = "Box Plot", value = FALSE),
                      checkboxInput("violin", label = "Violin Plot", value = FALSE),
                      checkboxInput("checkbox", label = "Linear Regression", value = FALSE),
                      checkboxInput("outlier", label = "Remove Outliers", value = FALSE),
                      checkboxInput("jitter", label = "jitter", value = TRUE),
                      checkboxInput("lognomial", label = "Log Plot", value = TRUE),
                      downloadButton("downloader", "Download", class = "btn btn-primary"),
                      
                      
                      hr(),
                      fluidRow(column(2, verbatimTextOutput("value"))
                      )
                      
                      
                      
             )),
           
           
           
           
           mainPanel(
             
             h3(textOutput("caption")),
             
             plotOutput("myplot")
           )
           
           
         )
)