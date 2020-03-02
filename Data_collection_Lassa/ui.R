#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that allows data input
ui <- fluidPage(title = "Lassa fever diagnostics data extraction",
                fluidRow(
                    column(width = 4,
                           Name,
                           Article_title,
                           First_author,
                           Year_studies,
                           Country_data,
                           Country_help,
                           Number_assays,
                           Assays_used,
                           Assay_detection,
                           Gold_standard,
                           Animal_species_number,
                           Animal_species_names,
                           Number_samples,
                           Number_positive,
                           Number_negative,
                           Reported_sensitivity,
                           Reported_specificity,
                           Other_comments,
                           actionButton("submit", "Submit")
                           )
                )
)

shinyApp(ui, server)

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
