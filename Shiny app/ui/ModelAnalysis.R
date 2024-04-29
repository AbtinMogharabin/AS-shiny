tabPanel('ModelAnalysis', icon=icon("external-link-square"),
         sidebarLayout(
           sidebarPanel(
             fluidRow(
               h5(strong('>>  Model: Analysis')), h5(strong('>> Modelling')), 
               h5(strong('>> Data: Asylum Seekers'))
             ),
             fluidRow( 
               column(12,selectInput("outcome", label = h5(strong("Outcome:")),  
                                     choices = list(
                                       "Total people pending at the start of the year" = "Total.persons.pending.start.year",
                                       "People UNHCR assisted " = "of.which.UNHCR.assisted",
                                       "People who applied during the year" = "Applied.during.year",
                                       "Decision recognized" = "statistics.filter.decisions_recognized",
                                       "Filter decision other" = "statistics.filter.decisions_other",
                                       "Rejected" = "Rejected",
                                       "Otherwise closed " = "Otherwise.closed",
                                       "Total decisions" = "Total.decisions",
                                       "Total pending at the end of year" = "Total.persons.pending.end.year",
                                       "Of which UNHCR assisted" = "of.which.UNHCR.assisted.1"), selected = 1))),
             fluidRow(
               column(12,selectInput("indepvar", label = h5(strong("Explanatory variable:")),
                                     choices = list(
                                       "Total people pending at the start of the year" = "Total.persons.pending.start.year",
                                       "People UNHCR assisted " = "of.which.UNHCR.assisted",
                                       "People who applied during the year" = "Applied.during.year",
                                       "Decision recognized" = "statistics.filter.decisions_recognized",
                                       "Filter decision other" = "statistics.filter.decisions_other",
                                       "Rejected" = "Rejected",
                                       "Otherwise closed " = "Otherwise.closed",
                                       "Total decisions" = "Total.decisions",
                                       "Total pending at the end of year" = "Total.persons.pending.end.year",
                                       "Of which UNHCR assisted" = "of.which.UNHCR.assisted.1"), selected = 1))), 
             selectInput("model_choice", label = h5("Choose a model"), 
                         choices = c(
                           "MLR", "SVR", "Random Forest"
                           , "Naive Bayes", 'K-Nearest Neighbors', "XGBoost", "LightGBM"
                         )),
             
             fluidRow(
               column(12,
                      ailgn="center",
                      textInput(inputId = "pred", label = h5(strong("Prediction input value:"))))),
             fluidRow(
               column(3,actionButton(inputId = 'go', label = "Predict!",icon = icon("play"), align = "center"))
             ),
             width = 2
           ),
           
           mainPanel(
             
             tabsetPanel(type = "tabs",
                         
                         tabPanel("Scatterplot",
                                  fluidRow(
                                    column(4, plotOutput("scatterplot"), offset = 2),
                                    column(4, plotOutput("heatmap"))),
                                  fluidRow(
                                    column(4, plotOutput("distribution1"), offset = 2),
                                    column(4, plotOutput("distribution2")))
                         ), # Plot
                         tabPanel("Linear Assumption", # Plots of distributions
                                  fluidRow(
                                    column(4, plotOutput("LinearityAssumptions1")))
                                  
                         ),
                         tabPanel("Model Summary", verbatimTextOutput("summary")), # Regression output
                         tabPanel("Prediction", verbatimTextOutput('predict') ) # Data as datatable 
             )
           )
         )
        )
