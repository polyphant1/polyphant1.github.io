# rpivotTable

# https://github.com/smartinsightsfromdata/rpivotTable


library(shiny)
library(shinydashboard)
library(rpivotTable)
library(ggplot2)

data(mtcars)

header <- dashboardHeader(title = "Data Profiler")

sidebar <- dashboardSidebar()

body <- dashboardBody(
  tags$head(tags$style(
    type = 'text/css',
    '#test{ overflow-x: scroll; }'
  )),
  rpivotTableOutput("test")
)

shinyApp(
  ui = dashboardPage(
    header, sidebar, body),
  server = function(input, output) {
    
    output$test <- rpivotTable::renderRpivotTable({
      rpivotTable(data = mtcars, rows="gear", col="cyl", aggregatorName="Average", 
                  vals="mpg", rendererName="Treemap")
    })
  }
)
