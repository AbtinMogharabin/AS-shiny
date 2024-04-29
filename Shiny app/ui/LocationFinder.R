tabPanel('Location Finder', icon = icon("globe-americas"),
         headerPanel(''),
         
         # Input values
         sidebarPanel(
           h3(strong('MAP')),
           
           
           
           selectInput("country1", label = "Country (if available):", 
                       choices = countrylist,
                       selected =1,
                       multiple=TRUE),
           
           fluidRow(
             column(12,selectInput("num_var", label = "Choose variable:", 
                                   choices = list("Total people pending at the start of the year" = "Total.persons.pending.start.year",
                                                  "People UNHCR assisted " = "of.which.UNHCR.assisted",
                                                  "People who applied during the year" = "Applied.during.year",
                                                  "Decision recognized" = "statistics.filter.decisions_recognized",
                                                  "Filter decision other" = "statistics.filter.decisions_other",
                                                  "Rejected" = "Rejected",
                                                  "Otherwise closed " = "Otherwise.closed",
                                                  "Total decisions" = "Total.decisions",
                                                  "Total pending at the end of year" = "Total.persons.pending.end.year",
                                                  "Of which UNHCR assisted" = "of.which.UNHCR.assisted.1"),
                                   selected =1))),
           
           
           sliderInput("year1", "Year:",
                       min = 2000, max = 2014,
                       value = 2000, sep = ""),
           
           actionButton("button", "Submit", icon = icon("play"), class = "btn btn-primary"), width = 3
         ),
         
         mainPanel(
           tags$label(h3(strong("Let's explore the map!"))),
           tags$div(class = "widget-user-header bg-red-active text-center"),
           leafletOutput("mymap", height = "500"),# Status/Output Text Box
           
         ))