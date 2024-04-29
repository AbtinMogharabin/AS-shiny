#Import Libraries
source(file.path("utils", "LibReader.R"),  local = TRUE)$value

#Import Data
source(file.path("utils", "DataReader.R"),  local = TRUE)$value

button_color_css <- "
#DivCompClear, #FinderClear, #EnterTimes{
/* Change the background color of the update button
to blue. */
background: DodgerBlue;
/* Change the text size to 15 pixels. */
font-size: 15px;
}"

ui <- fluidPage(
  #Navbar structure for UI
  navbarPage("AS-Shiny", theme = shinytheme("flatly"), #theme = shinytheme("superhero")
             source(file.path("ui", "About.R"),  local = TRUE)$value,
             source(file.path("ui", "LocationFinder.R"),  local = TRUE)$value,
             source(file.path("ui", "DataVisualization.R"),  local = TRUE)$value,
             source(file.path("ui", "ModelAnalysis.R"),  local = TRUE)$value,
             source(file.path("ui", "DataExplorer.R"),  local = TRUE)$value,
             source(file.path("ui", "Questions.R"),  local = TRUE)$value
             )
  )

server <- function(input, output) {
  source(file.path("server", "LocationFinder.R"),  local = TRUE)$value
  source(file.path("server", "DataVisualization.R"),  local = TRUE)$value
  source(file.path("server", "ModelAnalysis.R"),  local = TRUE)$value
  source(file.path("server", "DataExplorer.R"),  local = TRUE)$value
}

# Run the application
shinyApp(ui = ui, server = server)
