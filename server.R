# server.R

library(shiny)
library(ggplot2)
library(reshape2)

counts <-read.csv("data/transcriptome_fitted_vals_22Jun11.csv", as.is=T)
pvalues <- read.delim("data/transcriptome_annotated_20Jun11.tsv", as.is=T)

shinyServer(function(input, output) {
  output$graph <- renderPlot({
    
  })
})

# gets data into format: gene, expn, species, type
gene <- vector()
expn <- vector()
species <- vector()
type <- vector()

for (i in 2:13){
  tmp_name <- names(counts)[i]
  split_name <- strsplit(tmp_name, "[.]")
  
  for (j in 1:length(counts$X)){
    pos = (i - 2) * length(counts$X) + j
    gene[pos] <- counts$X[j]
    expn[pos] <- counts[, i][j]
    species[pos] <- split_name[[1]][1]
    type[pos] <- split_name[[1]][2]
  }
  
}
  
data <- cbind(gene, expn, species, type)
data <- data.frame(gene, expn, species, type, row.names = NULL)




counts$gene <- counts$X
ggplot(counts, aes(x = gene, ))