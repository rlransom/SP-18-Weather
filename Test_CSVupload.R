library("shiny")
library("tidyverse")
library("dplyr")
library("readr")
library("naniar")
library("lubridate")
library("DT")
#User interface
#Inputs and outputs
ui <- fluidPage(
  headerPanel(title = "Weather data curation"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Load data file', multiple = FALSE,
                accept = c(".csv")),
      selectInput("year", "Choose a year",c("2018", "2019", "2020")),
      selectInput("site", "Choose a location",c("Clinton", "Kinston")),
      downloadButton('downloadData', "Download modified file")
    ),
    mainPanel(
      DT::dataTableOutput('table')
    )
  )
) 

server <- function(input, output) {
  
  datasetInput <- reactive({
    switch(input$year,
           "2018" = 2018,
           "2019" = 2019,
           "2020" = 2020)
  })
  datasetInput <- reactive({
    switch(input$site,
           "Clinton" = Clinton,
           "Kinston" = Kinston)
  })  
  
  
  output$table <- DT::renderDataTable({
    
    infile <- input$file1
    
    req(infile)
    
    if (is.null(infile))
      return(NULL)
    
    Data <- reactive({read.csv(infile$datapath)})
    
    Data <- reactive ({naniar::replace_with_na_if(Data, .predicate = is.character, condition = ~.x %in% ("missing"))})
    
    #Data <- reactive({strftime(as.POSIXlt(Data()$Date, format = "%m/%d/%Y %h:m:s"), format="%W")})
    
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
} 


shinyApp(ui = ui, server = server)
