#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")

outputDir <- "Data_extraction"

# Define the fields we want to save from the form
fields <- c("Name", "Article title", "First Author", "Year(s) of data collection", "Country of data collection",
            "Number of different assay types used", "Assay type", "Assay detection method", "Use of a 'Gold Standard'",
            "Number of different animal species", "Animal species", "Number of samples", "Number positive", "Number negative", "Reported sensitivity", "Reported specificty",
            "Other comments")
full_text <- read.csv(file = "Data_collection_Lassa/Full_text_export.csv")

saveData <- function(input) {
    #put variables in a dataframe
    data <- data.frame(matrix(nrow = 1, ncol = 0))
    for (x in fields) {
        var <- input[[x]]
        if (length(var) > 1) {
            #this will allow interpreting list answers from questions
            data[[x]] <- list(var)
        } else {
            #otherwise data can be directly extracted
            data[[x]] <- var
        }
    }
    #collect time and date submitted
    data$submit_time <- date()
    
    #create a unique filename for each form
    fileName <- sprintf(
        "%s_%s.rds",
        as.integer(Sys.time()),
        digest::digest(data)
    )
    
    #write the file to the local system
    saveRDS(
        object = data,
        file = file.path(outputDir, filename)
    )
}
 
loadData <- function() {
    #read all the files into a list
    files <- list.files(outputDir, full.names = T)
    if (length(files) == 0) {
        #create empty dataframe with the question columns
        field_list <- c(fields, "submit_time")
        data <- data.frame(matrix(ncol = length(field_list), nrow = 0))
        names(data) <- field_list
    } else {
        data <- lapply(files, function(x) readRDS(x))
        #concatenate all data together into one data.frame
        data <- do.call(rbind, data)
    }
    data
}

#define the questions and the types ----
Name <- selectInput("Name", "What is your name?",
                    c("",
                      "David Simons",
                      "Lia Arruda",
                      "Najmul Haider"
                      )
                    )

Article_title <- selectInput("Article Title", "Which article are you extracting data from?",
                             c("title 1",
                               "title 2"))

First_author <- selectInput("First Author", "Who is the first author of the study?",
                            c("author 1",
                              "author 2"))

Year_studies <- numericInput("Year(s) of data collection", "When were the data collected (0 if not-stated)?",
                             min = 0, max = 2020, step = 1, value = 0)

Country_data <- textInput("Country of data collection", "Which country or countries were the data collected from?")
Country_help <- helpText("If there were multiple countries please state. If it was laboratory based and it states where the animals came from please include")

Number_assays <- numericInput("Number of different assay types used", "How many different asssays were used in the study?",
                              min = 0, max = 8, step = 1, value = 1)

Assays_used <- checkboxGroupInput(inputId = "Assay type",
                                  label = "Which assay(s) were used in this study",
                                  choices = c("Viral Isolation" = "vi",
                                              "Direct fluorescence" = "df",
                                              "IFA" = "ifa",
                                              "PCR" = "pcr",
                                              "ELISA" = "elisa"
                                    )
                                  )

Assay_detection <- checkboxGroupInput("Assay detection method", "Is the assay a direct or indirect method?",
                                      c("Direct detection" = "dd",
                                        "Indirect detection" = "id"))

Gold_standard <- checkboxGroupInput("Use of a 'Gold Standard'", "Was a 'Gold Standard' assay used?",
                                    c("Yes" = T,
                                      "No" = F))

Animal_species_number <- numericInput("Number of different animal species", "How many different animal species were used in the study?",
                                      min = 0, max = 8, step = 1, value = 1)

Animal_species_names <- checkboxGroupInput("Animal species", "Which animal species were included in this study?",
                                           c("Mastomys natalensis" = "m_n",
                                             "Monkey species_1" = "c_m"))

Number_samples <- numericInput("Number of samples", "How many samples were tested in the study?",
                               min = 1, max = 6000, step = 1, value = 1)

Number_positive <- numericInput("Number positive", "How many samples were positive?",
                                min = 1, max = 6000, step = 1, value = 1)

Number_negative <- numericInput("Number negative", "How many samples were negative?",
                                min = 1, max = 6000, step = 1, value = 1)

Reported_sensitivity <- numericInput("Reported sensitivity", "What was the reported sensitivity?",
                                     min = 1, max = 6000, step = 1, value = 1)

Reported_specificity <- numericInput("Reported specificity", "What was the reported specificity?",
                                     min = 1, max = 6000, step = 1, value = 1)

Other_comments <- textAreaInput("Other comments", "Are there any other data to be collected from this paper?")

resetForm <- function(session) {
    updateTextInput(session, c("Country_data"), value = "")
    updateSelectInput(session, c("Name", "Article_title", "First_author"), selected = character(0))
}

#reactive functions ----
server = function(input, output, session) {
    #when submit is clicked, save the form data
    observeEvent(input$submit, {
        saveData(input)
        resetForm(session)
    })
    #clear the fields
    observeEvent(input$clear, {
        resetForm(session)
    })
}

shinyApp(ui, server)





