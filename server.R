library(shiny)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  # Reactive expression to generate the requested distribution.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
  data <- reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
  })
  
  output$fileuploaded <-reactive({
    inFile <- input$file1
    return(!is.null(inFile))
  })
  outputOptions(output,"fileuploaded",suspendWhenHidden=FALSE)
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$boxplot <- renderPlot({
    boxplot(data.frame(data())[c("V2","V3","V4","V5","V6")])
    lines(tapply(data.frame(data()[["V3"]]),"V3",mean), col='blue', type='b') #加上平均值
  })
  
  output$plot2 <- renderPlot({
    hist(data.frame(data())[["V2"]])
  })
  output$plot3 <- renderPlot({
    hist(data.frame(data())[["V3"]])
  })
  output$plot4 <- renderPlot({
    hist(data.frame(data())[["V4"]])
  })
  output$plot5 <- renderPlot({
    hist(data.frame(data())[["V5"]])
  })
  output$plot6 <- renderPlot({
    hist(data.frame(data())[["V6"]])
  })
  
  output$pairs <- renderPlot({
    pairs(data.frame(data())[c("V2","V3","V4","V5","V6")])
  })
  
  output$sum <- renderPrint({
    rowSums(as.matrix(sapply(data.frame(data())[c("V2","V3","V4","V5","V6")],as.numeric)))
  })
  output$sumhist <- renderPlot({
    hist(rowSums(as.matrix(sapply(data.frame(data())[c("V2","V3","V4","V5","V6")],as.numeric))))
  })
  output$sumboxplot <- renderPlot({
    boxplot(rowSums(as.matrix(sapply(data.frame(data())[c("V2","V3","V4","V5","V6")],as.numeric))))
  })
  output$cor <- renderPrint({
    cor(data.frame(data())[c("V2","V3","V4","V5","V6")])
  })
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(data())
  })
  
})
