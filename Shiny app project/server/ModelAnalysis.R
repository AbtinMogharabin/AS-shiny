model <- reactive({
  y1 = d3[,input$outcome] ## outcome variable
  x1 = d3[,input$indepvar] ## independant variable
  subset_size <- 2500  # take a subset size
  x1 = x1[sample(subset_size)]
  y1 = y1[sample(subset_size)]
  
  if (input$model_choice == "MLR") {
    
    summary(lm(y1 ~ x1))
  } 
  
  
  else if (input$model_choice == "SVR") {
    model <- svm(y1 ~ x1, kernel = "linear")
    summary(model)  # Print the model summary
  }
  
  
  
  else if (input$model_choice == "Naive Bayes") {
    naiveBayes(y1 ~ x1, data = cbind(x1,y1))
  }
  
  
  ############################################################### 
  else if (input$model_choice == "Random Forest") {
    
    # Build the Random Forest model
    model <- randomForest(y1 ~ x1)
    
    # Print the model
    print(model)
    
    # Display variable importance
    var_importance <- model$importance
    print("Variable Importance:")
    print(var_importance)
  }
  else if (input$model_choice == "K-Nearest Neighbors"){
    
    data = cbind(x1,y1)
    
    parts = sample(2500 * .9)
    train = data[parts, ]
    test = data[-parts, ]
    
    
    train = data.matrix(train)
    test = data.matrix(test)
    
    train = as.matrix(train)
    test = as.matrix(test)
    
    train_scaled = scale(train[, -1])
    test_scaled = scale(test[, -1])
    
    
    test_pred <- knn(
      train = train_scaled, 
      test = test_scaled,
      cl = as.data.frame(train)$y1, 
      k=10
    )
    
    actual <- as.data.frame(test)$y1
    print(summary(test_pred))
    cm <- table(actual,test_pred)
    print(cm)
    accuracy <- sum(diag(cm))/length(actual)
    sprintf("Accuracy: %.2f%%", (1 - accuracy)*100)
    print(test_pred)
  }
  ###############################################################
  
  
  
  else if (input$model_choice == "LightGBM"){
    
    data = cbind(x1,y1)
    
    parts = sample(2500 * .9)
    train = data[parts, ]
    test = data[-parts, ]
    
    
    #define predictor and response variables in training set
    train_x1 = as.matrix(train[,-ncol(train)])
    train_y = as.matrix(train[,"y1"])
    
    #define predictor and response variables in testing set
    test_x1 = as.matrix(test[,-ncol(test)])
    test_y = as.matrix(test[,"y1"])
    
    # Data interface
    dtrain <- lgb.Dataset(train_x1, label = train_y)
    
    # Parameters
    params <- list(
      objective = "binary"
      , num_leaves = 4L
      , learning_rate = 1.0
    )
    
    # Train
    fit <- lgb.train(
      params
      , data = dtrain
      , nrounds = 10L
      , verbose = -1L
    )
    print("summary of the model results:")
    print(summary(predict(fit, test_x1) == test_y))
    print("")
    print("")
    print("")
    print("the models used:")
    print(lgb.train(
      params
      , data = dtrain
      , nrounds = 10L
      , verbose = -1L
    ))
  }
  
  
  else if (input$model_choice == "XGBoost"){
    
    data = cbind(x1,y1)
    
    parts = sample(2500 * .9)
    train = data[parts, ]
    test = data[-parts, ]
    
    
    #define predictor and response variables in training set
    train_x1 = as.matrix(train[,-ncol(train)])
    train_y = as.matrix(train[,"y1"])
    
    #define predictor and response variables in testing set
    test_x1 = as.matrix(test[,-ncol(test)])
    test_y = as.matrix(test[,"y1"])
    
    
    
    #define final training and testing sets
    xgb_train = xgb.DMatrix(data = train_x1, label = train_y)
    xgb_test = xgb.DMatrix(data = test_x1, label = test_y)
    watchlist = list(train=xgb_train, test=xgb_test)
    xgb.train(data = xgb_train, max.depth = 3, watchlist=watchlist, nrounds = 50)
  }
  
})

output$summary <- renderPrint({
  model()
})

# Prediction output
data = eventReactive(input$go, {
  as.numeric(input$pred)
})
output$predict <- renderPrint({
  
  y1 = d3[,input$outcome] ## outcome variable
  x1 = d3[,input$indepvar] ## independant variable
  
  fit <- lm(y1 ~ x1)
  
  data_frame = data.frame(x1 = data())
  pred_value  = predict(fit, data_frame, interval = 'confidence')
  cat('Machine Learning Models\nData                 : Asylum Seekers\nResponse variable    : y \nExplanatory variables: x\nInterval             : Confidence \nPrediction dataset   : Asylum Seekers')
  
  cat('\nY model prediction: ', pred_value[[1]], '\nY lower bound     : ', pred_value[[2]], '\nY upper bound     : ', pred_value[[3]] )
  
})




# Scatterplot output
output$scatterplot <- renderPlot({
  ggplot(data = log_data, aes(x = log_data[,input$indepvar], log_data[,input$outcome]))+
    geom_point(color = 'steel blue')+
    geom_smooth(method = lm, color = 'indianred3')+
    xlim(0,12)+
    ylim(0,12)+
    labs(title = 'Scatterplot', x = 'X value', y = 'Y value'  )+
    theme(plot.title = element_text(hjust = 0.5))
}, height=350, width = 400)

# Heatmap
output$heatmap = renderPlot({
  smoothScatter(log_data[,input$indepvar], log_data[,input$outcome], transformation = function(x) x ^ 0.4,
                colramp = colorRampPalette(c("#000099", "#00FEFF", "#45FE4F",
                                             "#FCFF00", "#FF9400", "#FF3100")), 
                main = 'HeatMap',xlab = 'X values', 
                ylab = 'Y values', 
                col.main = 'indianred3',
                col.lab = 'indianred3',col = 'indianred3')
  kern <- MASS::kde2d(log_data[,input$indepvar], log_data[,input$outcome])
  contour(kern, drawlabels = FALSE, nlevels = 6,
          col = rev(heat.colors(6)), add = TRUE, lwd = 3)
}, height=350, width = 400)

# Histogram output var 1
output$distribution1 <- renderPlot({
  ggplot(mapping = aes(x = log_data[,input$outcome] ), color = 'steel blue')+
    geom_histogram(color = 'sienna')+
    labs(title = 'Distribution of Y', x = 'Y values')+
    theme(plot.title = element_text(hjust = 0.5))
}, height=300, width=300)

# Histogram output var 2
output$distribution2 <- renderPlot({
  ggplot(mapping = aes(x = log_data[,input$indepvar] ), color = 'steel blue')+
    geom_histogram(color = 'sienna')+
    labs(title = 'Distribution of X', x = 'X value')+
    theme(plot.title = element_text(hjust = 0.5))
}, height=300, width=300)
# Linearity Assumptions
output$LinearityAssumptions1 = renderPlot({
  autoplot(lm(sample_data[,input$outcome] ~ sample_data[,input$indepvar]))
}, height = 500, width = 700)