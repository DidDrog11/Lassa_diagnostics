resetForm <- function(session) {
  updateTextInput(session, c("Country_data"), value = "")
  updateSelectInput(session, c("Name", "Article_title", "First_author"), selected = character(0))
}
