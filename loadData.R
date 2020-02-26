# funcitons to load data submittted to temp file
loadData <- function() {
  # Read all the files into a list
  filesInfo <- drop_dir("/hf/hfsheet.csv")
  filePaths <- filesInfo$path
  data <- lapply(filePaths, drop_read_csv, stringsAsFactors = FALSE)
  # Concatenate all data together into one data.frame
  data <- do.call(rbind, data)
  data 
}