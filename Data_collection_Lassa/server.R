#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")

outputDir <- "/Users/david/Google Drive/PhD/LIPS Review/LIPS_Review/Lassa_diagnostics/Data_collection_Lassa"

# Define the fields we want to save from the form
fields <- c("Name", "Article title", "First Author", "Year(s) of data collection", "Country of data collection",
            "Number of different assay types used", "Assay type", "Assay detection method", "Use of a 'Gold Standard'",
            "Number of different animal species", "Animal species", "Number of samples", "Number positive", "Number negative", "Reported sensitivity", "Reported specificity",
            "Other comments")
full_text <- read.csv(file = "Data_collection_Lassa/Full_text_export.csv")
full_text <- full_text[order(full_text$title),]
full_text$authors = as.character(gsub("\\..*","",full_text$authors))
species <- as.character(c("M. cynomolgus", "M. natalensis", "C. mona", "M. mulatta", "R. rattus", "M. erythroleucus",
             "P. daltoni", "C. sabaeus", "P. rostratus", "Crocidura species", "R. fuscipus", "M. munitoides",
             "M. mattheyi", "E. patas", "Cercopithecus species", "Other Rodentia species", "Other Non-human primate"))

server = function(input, output, session) {
    
    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
        data <- sapply(fields, function(x) input[[x]])
        data
    })
    
    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
        saveData(formData())
        resetForm(session)
        n_responses <- length(list.files(outputDir))
        response <- paste0("Thank you for completing data entry. This is record number ",
                           n_responses, ".")
        showNotification(response, duration = 0, type = "message")
        
    })
    
    # Show the previous responses
    # (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
        input$submit
        loadData()
    })     
}
