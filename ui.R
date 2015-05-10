# ui.R

library(shiny)

shinyUI(fluidPage(
  titlePanel("S. lycopersicum and S. pennellii tissue expression"),

  sidebarLayout(
    sidebarPanel(
      selectizeInput("gene",
                     label = h5("Enter desired gene name(s)"),
                     multiple = TRUE,
                     selected = "Solyc04g024840.2.1",
                     choices = c("Solyc04g024840.2.1")
      ),
      br()
    ),
    
    mainPanel(
      plotOutput("graph", width = "100%", height = "auto"),
      br(),
      tableOutput("table")
    )
  )
  
))