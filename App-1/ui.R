library(shiny)
library(ggplot2)

shinyUI(fluidPage(
    
    titlePanel("Experimental Power Calculator"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("n", label = "Number of subjects", value = 30),
            numericInput("mua", label = "Experimental Condition", value = 32),
            numericInput("mu0", label = "Control Condition", value = 30),
            numericInput("sigma", label = "Sigma (Standard Error)", value = 8),
            sliderInput("alpha", label = "Alpha Level",
                         min = 0.000001, max = .1, value = .05)
            ),
        
        mainPanel(
            plotOutput("plotfun")
        )
    )
))