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
  
  tmp_gene <- vector()
  tmp_expn <- vector()
  tmp_species <- vector()
  tmp_type <- vector()
  
  tmp_gene <- counts$X
  tmp_expn <- counts[, i]
  tmp_species <- rep(split_name[[1]][1], length(counts$X))
  tmp_type <- rep(split_name[[1]][2], length(counts$X))
  
  if (i == 2){
    gene <- tmp_gene
    expn <- tmp_expn
    species <-tmp_species
    type <- tmp_type
  } else {
    gene <- rbind(gene, tmp_gene)
    expn <- rbind(expn, tmp_expn)
    species <-rbind(species, tmp_species)
    type <- rbind(type, tmp_type)
  }
  
}

data <- cbind(gene, expn, species, type)
data <- data.frame(gene, expn, species, type, row.names = NULL)
  

# for (i in 2:13){
#   tmp_name <- names(counts)[i]
#   split_name <- strsplit(tmp_name, "[.]")
#   
#   tmp_gene <- vector()
#   tmp_expn <- vector()
#   tmp_species <- vector()
#   tmp_type <- vector()
#   
#   for (j in 1:length(counts$X)){
#     pos = (i - 1) * j
#     tmp_gene[pos] <- counts$X[pos]
#     tmp_expn[pos] <- counts[, i][pos]
#     tmp_species[pos] <- split_name[[1]][1]
#     tmp_type[pos] <- split_name[[1]][2]
#   }
#   
#   
#   #   if (i == 2){
#   #     gene <- tmp_gene
#   #     expn <- tmp_expn
#   #     species <-tmp_species
#   #     type <- tmp_type
#   #   } else {
#   #     gene <- rbind(gene, tmp_gene)
#   #     expn <- rbind(expn, tmp_expn)
#   #     species <-rbind(species, tmp_species)
#   #     type <- rbind(type, tmp_type)
#   #   }
#   #   
# }
  
counts$gene <- counts$X
ggplot(counts, aes(x = gene, ))