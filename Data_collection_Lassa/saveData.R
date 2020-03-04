saveData <- function(data) {
  data <- t(data)
  #fileName <- "data_extraction.csv"
  fileName <- "data_extraction.json"
  # Write the file to the local system
  #write.table(
  #  x = data,
  #  file = file.path(outputDir, fileName), 
  #  row.names = F, col.names = F,
  #  append = TRUE,
  #  sep = ","
  #)
  sink(file="data_extraction.json",append=TRUE)
  cat(data)
  sink()
}
