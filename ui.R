# ui.R

library(shiny)

# gets the list of genes in this data set
counts <-read.csv("data/transformed_transcriptome_fitted_vals.csv", as.is=T)
gene_list <- unique(counts$gene)

shinyUI(fluidPage(
  titlePanel("S. lycopersicum and S. pennellii tissue expression"),
  
  sidebarLayout(
    sidebarPanel(     
      selectizeInput("gene", label = h5("Enter desired gene name(s) separated by commas"),
                     multiple = TRUE, selected = "Solyc04g024840.2.1",
                     choices = gene_list,
      ),
      br()
    ),
    
    mainPanel(
      plotOutput("graph"),
      br(),
      tableOutput("table")
    )
  )
  
))