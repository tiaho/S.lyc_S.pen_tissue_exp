# ui.R

library(shiny)

shinyUI(fluidPage(
  titlePanel("S.lyc and S.pen tissue expression"),
  
  sidebarLayout(
    sidebarPanel(     
      
    ),
    
    mainPanel(
      plotOutput("graph"),
    )
  )
  
))