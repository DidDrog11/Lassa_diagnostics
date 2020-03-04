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

server = function(input, output, session) {
    
    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
        #data <- sapply(fields, function(x) input[[x]])
        
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
