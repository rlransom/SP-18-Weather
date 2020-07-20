library("shiny")
library("readxl")
library("tidyverse")
library("dplyr")
library("readr")
library("naniar")
library("lubridate")
#User interface
#Inputs and outputs
ui <- fluidPage(
  headerPanel(title = "Weather data curation"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Load xlsx file', NULL,
                accept = c(".xlsx")),
      selectInput("year", "Choose a year",c("2018", "2019", "2020")),
      selectInput("site", "Choose a location",c("Clinton", "Kinston")),
      downloadButton('file2', "Download modified file")
    ),
    mainPanel(
      tableOutput('table')
    )
  )
) 

server <- function(input, output) {
  output$table <- renderTable({
    
    req(input$file1)
    
    Data <- read_excel(input$file1$datapath, 1)
    
    Data <- naniar::replace_with_na_if(Data, .predicate = is.character, condition = ~.x %in% ("missing"))
    
    Data$Date <- as.Date(Data$Date)
    
    #Change column type to numeric
    names <- colnames(Data)[-1]
    Data <- Data %>%
      mutate_at(names, as.numeric)
    
    #Express percentages as fractions
    Data <- Data %>%
      mutate(Relative_Humidity = Relative_Humidity/100)
    
  })
  
} 


shinyApp(ui = ui, server = server)
