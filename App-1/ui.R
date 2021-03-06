library(shiny)
library(ggplot2)

shinyUI(fluidPage(
    
    titlePanel("Experimental Power Calculator"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("n", label = "Number of observations", value = 30),
            numericInput("mua", label = "Experimental Condition", value = 32),
            numericInput("mu0", label = "Control Condition", value = 30),
            numericInput("sigma", label = "Standard Deviation", value = 8),
            sliderInput("alpha", label = "Alpha Level",
                         min = 0.000001, max = .1, value = .05)
            ),
        
        mainPanel(
            
            h3("How to Use:"),
            
            p("Ideally, before collecting data, one of the first steps a 
              scientist should perform is an examination of", 
              a(href = "http://en.wikipedia.org/wiki/Statistical_power", "the statistical power
              their research design can support."), br(), "In the case of behavioral,
              or psychological research, the question of participant compensation,
              or the availability of certain populations may be a restriction on 
              on the amount of observations a researcher can collect. If you're
              performing an experiment, and the effect you're hoping to test is very
              small, a certain number of observations will need to be collected 
              without falling risk to", a(href = "http://en.wikipedia.org/wiki/Type_I_and_type_II_errors", "type-II errors.")), 
            
            br(),
            
            p("The sidebar allows you to enter different values (if you were planning
              an experiment, for example), and the calculator will then display
              the results of the power analysis, along with the effect size expected
              from the differences between conditions. The graph then visualizes the
              distributions of both the experimental and control conditions based off
              the values you select."),
            
            p("Power is visualized as the area (under the exp. condition's curve) right of the black line if the experimental
              mean is larger than the control. The opposite is true if the experimental
              condition is smaller than the control. The effect size is a metric
              that reflects the difference between the conditions."),
            a(href = "http://en.wikipedia.org/wiki/Effect_size", "Effect-Size, Wikipedia"),
            p("Hopefully, this graphical display will help you
              more intuitively understand how power corresponds to sample size, and 
              measures of spread."),
            
            plotOutput("plotfun")
        )
    )
))