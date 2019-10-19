library(shiny)
library(datasets)

# Usando o conjunto de dados `mtcars`.

mpg <- mtcars
# Define UI.
ui <- fluidPage(
  
  titlePanel("Histograma das variáveis de mtcars"),
  
  sidebarLayout(
    
    selectInput("Ind","Variável",
                choices = names(mpg)),
      
    # Main panel para exibir os outputs.
    mainPanel(
      # Output: Plot da variável selecionada.
      plotOutput("hist")
      
    )
  )
)


# Define o server para gerar os outputs.
server <- function(input, output, session) {
  data1 <- reactive({
    input$Ind
  })
  # Gerar o gráfico da variável selecionada.
  output$hist <- renderPlot({
    req(data1())
    hist(mpg[[data1()]], col = "#007481", border="black",
         xlab = " ", main = " ")
  }) 
}

# Criar Shiny app.
shinyApp(ui, server)

