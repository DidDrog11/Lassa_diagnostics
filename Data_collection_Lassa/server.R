#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
setwd("/Users/david/Google Drive/PhD/LIPS Review/LIPS_Review/Lassa_diagnostics/Data_collection_Lassa")
outputDir <- getwd()

# Define the fields we want to save from the form
fields <- c("Name", "Article_title", "First_author", "Number_species", "Year_data", "Country_data",
            "Number_assay", "Assay_type", "other_assay", "Gold_standard",
            "Animal_species", "Number_samples", "Number_positive", "Number_negative", "Reported_sensitivity", "Reported_specificity",
            "Other comments")
full_text <- read.csv(file = "Full_text_export.csv")
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
        response <- paste0("Thank you for completing data entry for this study: ",
                           input$Article_title, ".")
        showNotification(response, duration = 0, type = "message")
        
    })
    
    # Show the previous responses
    # (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
        input$submit
        loadData()
    })     
}
