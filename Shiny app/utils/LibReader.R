
# Required libraries list
required_libraries <- c(
  "dplyr", "ggplot2", "shiny", "DT", "ggrepel", 
  "tidyr", "shinycssloaders", "shinythemes", "ggfortify", 
  "leaflet", "ggthemes", "DT", "dplyr", "plotly", "e1071", 
  "naivebayes", "caret", "glmnet", "xgboost", "lightgbm", 
  "randomForest", "gbm", "kernlab", "adabag"
)

# Install the libraries that are not installed before
for (lib in required_libraries) {

  if (!requireNamespace(lib, quietly = TRUE)) {

    install.packages(lib)
  }
}

# Import the libraries
library(dplyr)
library(ggplot2)
library(shiny)
library(DT)
library(ggrepel)
library(tidyr)
library(shinycssloaders)
library(shinythemes)
library(ggfortify)
library(leaflet)
library(ggthemes)
library(DT)
library(dplyr)
library(plotly)
library(e1071)
library(naivebayes)
library(caret)
library(glmnet)
library(xgboost)
library(lightgbm)
library(randomForest)
library(gbm)
library(kernlab)
library(adabag)