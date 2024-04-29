tabPanel("Questions",icon = icon("question-circle"),
         fluid = TRUE,
         fluidRow(
           column(8,
                  h3(p("Some questions that could be researched on based on our shiny app:")),
                  h5(p("Do refugees and Venezuelans displaced abroad lived in countries neighbouring their countries of origin?"),
                     p("Do refugees usually returne or resettle from the new country they have moved to?"),
                     p("At the times that UNHCR assisted, did the number of rejected applications change?"),
                     p("What were the countries with the most number of people taking refugee from them?"),
                     p("What were the countries with the most number of people taking refugee to them?"),
                     p("Do famous developing countries host more refugees then others?"),
                     p("Analysis of top international displacement situations by country of origin."),
                     p("How is the refugee density different in different times of world crisis? (Such as the 2007-2008 food crisis or the 2011 East Africa drought, etc.)"),
                     p(""),
                     br(),
                     br(),
                     h5(p("I hope you found our Shiny App useful.  Any comments or questions are welcome at atbinmogharabin@gmail.com"),
                        p("The source code is available ", a("here", href = "https://github.com/abtinmogharabin"), "."))
                     
                     #hr(),
                  )
           )
         ),
         br(),
         hr(),
         h5("Sources:"),
         h6(
           p("Asylum Information from ",
             a("asylum-applications",
               href = "https://data.world/unhcr/asylum-applications/"))),
         h5("Built with",
            img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
            
         )
         
)