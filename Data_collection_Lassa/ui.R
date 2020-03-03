#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#define the questions and the types ----
ui <- fluidPage(title = "Lassa fever diagnostics data extraction",
                fluidRow(
                  column(width = 6, 
                         selectInput("Name", "What is your name?",
                                     c("",
                                       "David Simons",
                                       "Lia Arruda",
                                       "Najmul Haider")),
                         selectInput("Article_title", "Which article are you extracting data from?", 
                                     choices = c("", as.character(full_text$title))),
                                     helpText("Select the article from the drop-down for which you are entering data"),
                         selectInput("First_author", "Who is the first author of the study?",
                                     choices = c("", full_text$authors)),
                                     helpText("Please select the first authors name to act as a double check"),
                         numericInput("Year_data", "When were the data collected (0 if not-stated)?",
                                      min = 0, max = 2020, step = 1, value = 0),
                                     helpText("If this can be extracted from the text when were the experiments done or data collected?"),
                         textInput("Country_data", "Which country or countries were the data collected from?"),
                                     helpText("If there were multiple countries please state this. If it was laboratory based and it states where the animals came from please include this too"),
                         numericInput("Number_assay", "How many different asssays were used in the study?",
                                      min = 0, max = 8, step = 1, value = 1),
                                     helpText("If no assays where used the rest of the questions should remain hidden, but please make sure you press submit before moving on"),
                         conditionalPanel(condition = "input.Number_assay >= 1",
                                          checkboxGroupInput(inputId = "Assay_type",
                                                             label = "Which assay(s) were used in this study",
                                                             choices = c("Direct detection: Viral Isolation" = "vi",
                                                                         "Direct detection: PCR" = "pcr",
                                                                         "Direct detection: Sequencing" = "seq",
                                                                         "Direct detection: Direct fluorescence" = "df",
                                                                         "Indirect detection: Immunofluorescence assay (IFA)" = "ifa",
                                                                         "Indirect detection: Antigen ELISA" = "ag_elisa",
                                                                         "Indirect detection: Antibody ELISA" = "ab_elisa",
                                                                         "Indirect detection: Rapid Diagnostic Test" = "rdt",
                                                                         "Other: which?" = "other"
                                                                         )),
                                          conditionalPanel(condition = "input.Assay_type.includes(`Other: which?`)",
                                                           textInput("other_assay", "Name of other assay")),
                                          # checkboxGroupInput("Assay_detection", "Is the assay a direct or indirect method?",
                                          #                    c("Direct detection" = "dd",
                                          #                      "Indirect detection" = "id")
                                          #                    ),
                                          checkboxInput("Gold_standard", "Tick if test compared to a 'Gold Standard' assay",
                                                             c("Yes" = T,"No" = F),
                                                        value = F),
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
                         actionButton("submit", "Submit"))
                )
)


shinyApp(ui, server)
