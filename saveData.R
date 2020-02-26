# funcitons to save data submittted 
saveData <- function(data,Filename) {
  # transpose the data 
  data <- t(data)
  # Create a unique file name
  #fileName <- sprintf("hf.csv", as.integer(Sys.time()), digest::digest(data))
  # Write the data to a temporary file locally
filePath <- file.path(tempdir())
  # write temp data to csv file 
  write.csv(data, paste0(filePath,"/",Filename), row.names = FALSE, quote = TRUE)
  # Upload the file to Dropbox
  drop_upload( paste0(filePath,"/",Filename), path = "responses", mode = "add")
}

