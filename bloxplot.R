library(shiny)
library(datasets)

# Usando o conjunto de dados `mtcars`.
# Rotulando a coluna am para melhor analise.

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
mpgData$vs <- factor(mpgData$vs, labels = c("V-shaped", "straight"))

# Define UI.
ui <- fluidPage(
  
  titlePanel("Boxplot em relação a variável mpg"),
  
  # Sidebar layout com definições de input e output.
  sidebarLayout(
    
    # Sidebar panel para inputs.
    sidebarPanel(
      
      # Input: Seleciona as variáveis para plotagem
      # em relação a mpg.
      selectInput("variable", "Variável:",
                  c("Carburadores" = "carb",
                    "Cilindros" = "cyl",
                    "Marchas" = "gear",
                    "Motor" = "vs",
                    "Transmissão" = "am")),
      
      # Input: Box para inclusão de outliers.
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    # Main panel para exibir os outputs.
    mainPanel(
      
      # Output: Formatar texto para caption.
      h3(textOutput("caption")),
      
      # Output: Plot da variável selecionada em relação a mpg.
      plotOutput("mpgPlot")
      
    )
  )
)

# Define o server para gerar os outputs.
server <- function(input, output) {
  
  # Título do gráfico.

  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Retornar a formula text como caption.
  output$caption <- renderText({
    formulaText()
  })
  
  # Gerar o gráfico da variável selecionada em relação a mpg,
  # e exclui valores outliers se pedido.
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#40E0D0", pch = 16)
  })
  
}

# Criar Shiny app.
shinyApp(ui, server)
