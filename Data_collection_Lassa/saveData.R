saveData <- function(data) {
  data <- t(data)
  fileName <- "data_extraction.csv"
  # Write the file to the local system
  write.table(
    x = data,
    file = file.path(outputDir, fileName), 
    row.names = FALSE, quote = TRUE,
    append = TRUE
  )
}
