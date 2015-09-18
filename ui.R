library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  titlePanel("Uploading Files"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      conditionalPanel("output.fileuploaded",
        tabsetPanel(type = "tabs", 
                    tabPanel("BoxPlot", plotOutput("boxplot")),
                    tabPanel("Plot", plotOutput("plot2"),plotOutput("plot3"),plotOutput("plot4"),plotOutput("plot5"),plotOutput("plot6")),
                    tabPanel("Pairs", plotOutput("pairs")),
                    tabPanel("Sum", verbatimTextOutput("sum"),plotOutput("sumhist"),plotOutput("sumboxplot")),
                    tabPanel("Cor", verbatimTextOutput("cor")),
                    tabPanel("Summary", verbatimTextOutput("summary")), 
                    tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )
  )
)
