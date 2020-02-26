
#### Shiny app user server ####
server <- function(input, output, session) {

  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form1")}
  }
  )
  
  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form2")}
  }
  )
  
  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form3")}
  }
  )

  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form4")}
  }
  )
  
  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form5")}
  }
  )
  
  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form6")}
  }
  )
  
  observeEvent(input$go, {
    if (input$password == "hfim2020")
    {shinyjs::show("form7")}
  }
  )



  
  fieldnames <- colnames(drop_read_csv("/hf/hfsheet.csv", dest=tempdir()))
  
  formData <- reactive({
    data <- sapply(fieldnames, function(x) input[[x]])
    data
  })
  
  observeEvent(input$submit, {
    shinyalert(title = "Sumbission successful", type = "success")
  })
  
  observeEvent(input$submit, {
    saveData(data = formData(), 
             Filename = paste0("hf_", input$name,"_", input$publicationid, "_", Sys.time(), ".csv"))
  })
  
}
