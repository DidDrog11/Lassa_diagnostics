#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#define the questions and the types ----
ui <- fluidPage(title = "Lassa fever diagnostics data extraction",
                fluidRow(
                  column(width = 4,
                         selectInput("Name", "What is your name?",
                                     c("",
                                       "David Simons",
                                       "Lia Arruda",
                                       "Najmul Haider")),
                         selectInput("Article_title", "Which article are you extracting data from?",
                                     choices = as.character(full_text$title)),
                         selectInput("First_author", "Who is the first author of the study?",
                                     choices = full_text$authors),
                         numericInput("Year_data", "When were the data collected (0 if not-stated)?",
                                      min = 0, max = 2020, step = 1, value = 0),
                         textInput("Country_data", "Which country or countries were the data collected from?"),
                         helpText("If there were multiple countries please state this. If it was laboratory based and it states where the animals came from please include this too"),
                         numericInput("Number_assay", "How many different asssays were used in the study?",
                                      min = 0, max = 8, step = 1, value = 1),
                         conditionalPanel(condition = "input.Number_assay >= 1",
                                          checkboxGroupInput(inputId = "Assay_type",
                                                             label = "Which assay(s) were used in this study",
                                                             choices = c("Viral Isolation" = "vi",
                                                                         "Direct fluorescence" = "df",
                                                                         "IFA" = "ifa",
                                                                         "PCR" = "pcr",
                                                                         "Sequencing" = "sequencing",
                                                                         "ELISA" = "elisa")
                                                             ),
                                          checkboxGroupInput("Assay_detection", "Is the assay a direct or indirect method?",
                                                             c("Direct detection" = "dd",
                                                               "Indirect detection" = "id")
                                                             ),
                                          checkboxInput("Gold_standard", "Tick if test compared to a 'Gold Standard' assay",
                                                             c("Yes" = T,
                                                               "No" = F)),
                                          numericInput("Number_species", "How many different animal species were used in the study?",
                                                       min = 0, max = 8, step = 1, value = 0),
                                          conditionalPanel(condition = "input.Number_species >= 1",
                                                           checkboxGroupInput("Animal_species", "Which animal species were included in this study?",
                                                                              species),
                                                           numericInput("Number_samples", "How many samples were tested in the study?",
                                                                        min = 1, max = 6000, step = 1, value = 0),
                                                           numericInput("Number_positive", "How many samples were positive?",
                                                                        min = 1, max = 6000, step = 1, value = 0),
                                                           numericInput("Number_negative", "How many samples were negative?",
                                                                        min = 1, max = 6000, step = 1, value = 0),
                                                           numericInput("Reported_sensitivity", "What was the reported sensitivity?",
                                                                        min = 1, max = 6000, step = 1, value = 0),
                                                           numericInput("Reported_specificity", "What was the reported specificity?",
                                                                        min = 1, max = 6000, step = 1, value = 0),
                                                           ),
                         ),
                         textAreaInput("Other comments", "Are there any other data to be collected from this paper?"),
                         actionButton("submit", "Submit")
                  )
                )
)


shinyApp(ui, server)

# # Define UI for application that allows data input
# ui <- fluidPage(title = "Lassa fever diagnostics data extraction",
#                 fluidRow(
#                     column(width = 4,
#                            Name,
#                            Article_title,
#                            First_author,
#                            Year_studies,
#                            Country_data,
#                            Country_help,
#                            Number_assays,
#                            Assays_used,
#                            Assay_detection,
#                            Gold_standard,
#                            Animal_species_number,
#                            Animal_species_names,
#                            Number_samples,
#                            Number_positive,
#                            Number_negative,
#                            Reported_sensitivity,
#                            Reported_specificity,
#                            Other_comments,
#                            actionButton("submit", "Submit")
#                            )
#                 )
# )

# ui <- fluidPage(
#     title = "Lassa Fever Diagnostics Data Extraction",
#     #CSS ----
#     tags$head(
#         tags$style(HTML("
#                         .shiny-input-container:not(.shiny-input-container-inline) {
#             width: 100%;
#             max-width: 100%;
#         }
#         "))
#     ),
#     # App title ----
#     h3("Lassa survey"),
#     p("Please complete the following form for each paper you have been assigned"),
#     fluidRow(
#         column(width = 4,
#                Name,
#                Article_title)
#     )
# )
