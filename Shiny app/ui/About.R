navbarMenu("About", icon = icon("info-circle"),
           tabPanel("Our Dataset", fluid = TRUE,
                    fluidRow(
                      column(6,
                             h4(p("ABOUT THE DATA")),
                             h5(p("This data was acquired from the UNHCR Population Statistics database. It presents information about asylum applications lodged in almost 200 countries across the globe between the years 2000 and 2014. Data are broken down by month and country of origin."),
                                br(),
                                p("UNHCR's populations of concern include refugees, asylum-seekers, Internally Displaced Persons (IDPs), stateless persons and individuals who do not necessarily fall directly into any of the groups above, but to whom UNHCR extends its protection and/or assistance services, based on humanitarian or other special grounds."),
                                br(),
                                p("Sources include UNHCR Population Statistics and UNHCR Populations of Concern."),
                             )
                      ),
                      HTML('<img src="https://donate.unhcr.org/sites/default/files/styles/social_large/public/2021-07/MicrosoftTeams-image%20%287%29.png?h=9b44de68&itok=2CEkypeH", height="300px"
                                        style="float:left"/>','<p style="color:black"></p>'),
                      br()
                    )
           ),
           tabPanel("Our Work", fluid = TRUE,
                    fluidRow(
                      column(6,
                             #br(),
                             h4(p("ABOUT THE PROJECT")),
                             h5(p("Our data gave us a chance to access information about people who had been forced to leave their homes and hope for a better life ahead. As international students, we instantly connected and related to the idea! We come from countries where many have faced these problems firsthand and we understand how huge of a problem this is. We believe that the plight of these people is an underrecognized determinant of humanity our societal progression and should be given the importance it deserves. It should discussed by more people on more levels, thus, we decided to bring it up!")),
                             br(),
                             h5(p("Our interactive app can provide easy access to over 100,000 datapoints collected for 14 variables over the span of 15 years! This can not only prove to be helpful for people who want to learn about this grave issue, but also for human rights activists who want easy access to facts AND the underprivileged people who want to find the safest place for refuge and asylum. ")),
                             br(),
                             h5(p("We provide a range of services: from smart searching and exploration of the data, to stunning and easy to understand visuals (including maps, plots and linear regression models).")),
                      ),
                    )
                   )
          )
