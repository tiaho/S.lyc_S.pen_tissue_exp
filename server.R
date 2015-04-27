# server.R

library(shiny)
library(ggplot2)

counts <-read.csv("data/transformed_transcriptome_fitted_vals.csv", as.is=T)
pvalues <- read.delim("data/transcriptome_annotated_20Jun11.tsv", as.is=T)

shinyServer(function(input, output) {
  
  # graph
  output$graph <- renderPlot({
    data <- vector()
    for (i in 1:length(input$gene)){
      gene_exist <- match(input$gene[i], counts$gene, nomatch = 0)
      if (gene_exist == 0){
        stop(paste(input$gene, "does not exist"))
      } else{
        place_counts <- grep(input$gene[i], counts$gene)
        for (j in 1:length(place_counts)){
          pos <- place_counts[j]
          tmp_row <- counts[pos,]
          if (i == 1 & j == 1){
            data <- tmp_row
          } else{
            data <- rbind(data, tmp_row)
          }
        }
      } 
    }
    
    # log2 transform the expression values
    data$expn <- log2(data$expn)
    
    # changes some names in the file
    for (i in 1:length(data$species)){ 
      # goes through the species column
      if (data$species[i] == "M82"){ 
        data$species[i] = "S. lycopersicum"
      } else if (data$species[i] == "LA716"){
        data$species[i] = "S. pennellii"
      }
      # goes through the type column
      if (data$type[i] == "veg"){ 
        data$type[i] = "vegetative shoot apex"
      } else if (data$type[i] == "Inf"){
        data$type[i] = "inflourescence shoot apex"
      } else if (data$type[i] == "sdling"){
        data$type[i] = "seedling"
      } else if (data$type[i] == "Leaf"){
        data$type[i] = "leaf"
      }
    }
    
    # plots the graph
    ggplot(data, aes(x = type, y = expn)) + 
      geom_bar(stat = "identity", position = "dodge", aes(fill = species)) +
      facet_wrap( ~ gene, ncol = 4) +
      theme(axis.text.x = element_text(angle = 90)) +
      scale_fill_discrete(name = "Species") +
      xlab("Type of Tissue") +
      ylab("Expression in log2(count)")
    
  })

  # produces data for the table
  table_data <- reactive({
    data <- vector()
    for (i in 1:length(input$gene)){
      row <- vector()
      gene <- input$gene[i]
      search_phrase <- strsplit(gene, "\\.")[[1]][1]
      pos <- grep(search_phrase, pvalues$ITAG)
      row[1] <- gene
      row[2:4] <- pvalues[pos, 2:4]
      if (i == 1){
        data <- row
      } else {
        data <- rbind(data, row)
      }
    }
    data <- data.frame(data)
    names(data) <- c("gene", "species effect", "tissue effect", "species x tissue effect")
    data
  })
  
  # table
  output$table <- renderTable({
    table_data()
  }, include.rownames = FALSE)

})