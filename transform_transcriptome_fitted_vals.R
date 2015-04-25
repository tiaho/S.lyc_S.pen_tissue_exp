counts <-read.csv("data/transcriptome_fitted_vals_22Jun11.csv", as.is=T)

# gets data into format: gene, expn, species, type
gene <- vector()
expn <- vector()
species <- vector()
type <- vector()

for (i in 2:13){ # loops through each column in the orignal file
  tmp_name <- names(counts)[i]
  split_name <- strsplit(tmp_name, "[.]")
  
  for (j in 1:length(counts$X)){ # loops through each row in the orignal file
    pos = (i - 2) * length(counts$X) + j
    gene[pos] <- counts$X[j]
    expn[pos] <- counts[, i][j]
    species[pos] <- split_name[[1]][1]
    type[pos] <- split_name[[1]][2]
  }
  
}

#  combines the individual vectorss
data <- cbind(gene, expn, species, type)
data <- data.frame(gene, expn, species, type, row.names = NULL)

# writes out the table
write.csv(data, file = "transformed_transcriptome_fitted_vals.csv", row.names = FALSE)
