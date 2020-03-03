resetForm <- function(session) {
  updateTextInput(session, c("Country_data",
                             "Other_assay"), value = "")
  updateSelectInput(session, c("Name",
                               "Article_title",
                               "First_author"))
  updateNumericInput(session, c("Year_data",
                                "Number_assay",
                                "Number_species",
                                "Number_samples",
                                "Number_positive",
                                "Number_negative",
                                "Reported_sensitivty",
                                "Reported_specificity"))
  updateTextAreaInput(session, c("Other comments"))
}
