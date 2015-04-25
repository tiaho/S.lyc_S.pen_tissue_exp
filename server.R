# server.R

library(shiny)
library(ggplot2)
library(reshape2)

counts <-read.csv("data/transformed_transcriptome_fitted_vals.csv", as.is=T)
pvalues <- read.delim("data/transcriptome_annotated_20Jun11.tsv", as.is=T)

shinyServer(function(input, output) {
  output$graph <- renderPlot({
    
  })
})



counts$gene <- counts$X
ggplot(counts, aes(x = gene, ))