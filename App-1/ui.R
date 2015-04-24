library(shiny)
library(ggplot2)

shinyUI(fluidPage(
    
    titlePanel("My app!"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("n", label = "Number of subjects", value = 30),
            numericInput("muA", label = "Experimental Group", value = 32),
            numericInput("mu0", label = "Control group", value = 30),
            numericInput("sigma", label = "Sigma", value = 8),
            numericInput("alpha", label = "Alpha Level", value = .05)
            ),
        
        mainPanel(
            plotOutput("plotfun")
        )
    )
))