tabPanel('DataExplorer',icon = icon("table"),
         titlePanel("Exploring the Dataset: Asylum Seekers"),
         sidebarLayout(
           sidebarPanel(
             sliderInput("Year11", label = h3("Year"),
                         min = 2000, max = 2014,
                         value = c(2000,2014),sep = ""),
             selectInput("CountryofOrigin11", label = h3("Country of Origin"),
                         choices = sort(unique(d3[["Origin"]])), selected = 0,
                         multiple = TRUE),
             selectInput("CountryofAsylum11", label = h3("Country of Asylum"),
                         choices = sort(unique(d3[["Country...territory.of.asylum.residence"]])), selected = 0,
                         multiple = TRUE),
             selectInput('checkGroup', label = h3('Choose the variables to view the summary'), 
                         choices = list('Year'='Year'                                
                                        ,'Country/Territory of asylum residence'='Country...territory.of.asylum.residence'
                                        ,'Country of origin'='Origin'                              
                                        ,"Total people pending at the start of the year" = "Total.persons.pending.start.year"
                                        ,"People UNHCR assisted " = "of.which.UNHCR.assisted",
                                        "People who applied during the year" = "Applied.during.year",
                                        "Decision recognized" = "statistics.filter.decisions_recognized",
                                        "Filter decision other" = "statistics.filter.decisions_other",
                                        "Rejected" = "Rejected",
                                        "Otherwise closed " = "Otherwise.closed",
                                        "Total decisions" = "Total.decisions",
                                        "Total pending at the end of year" = "Total.persons.pending.end.year",
                                        "Of which UNHCR assisted" = "of.which.UNHCR.assisted.1"),
                         selected = 1,
                         multiple=TRUE),
             actionButton("update11", "Update View", icon = icon("refresh"), class = "btn btn-primary")),
           
           
           mainPanel(
             
             tabsetPanel(type = "tabs",
                         tabPanel("Data", DT::dataTableOutput('tbl11')), # Data as datatable
                         tabPanel("Summary",
                                  verbatimTextOutput('summary11'))
                         # Summary  
             )
           )
         )
)
