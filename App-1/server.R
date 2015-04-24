library(shiny)
library(ggplot2)

shinyServer(function(input, output){
    
    ## What kind of plot do I want to make?
    
    myplot <- function(sigma, mua, mu0, n, alpha) {
        g <- ggplot(data.frame(axis = c(mu0 - (sigma / 2), mua + (sigma / 2))),
                    aes(x = axis))
        
        g <- g + stat_function(fun = dnorm, geom = "line", 
                               args = list(mean = mu0, 
                                           sd = sigma / sqrt(n)),
                               size = 1, col = "red", linetype = "dotdash")
        g <- g + stat_function(fun = dnorm, geom = "line",
                               args = list(mean = mua, sd = sigma/ sqrt(n)),
                               size = 1, col = "blue", linetype = "dotdash")
        
        xitc <- mu0 + qnorm(1 - alpha) * sigma / sqrt(n)
        
        g <- g + geom_vline(xintercept = xitc, size = 2)
        
        g
    }
    
    output$plotfun <- renderPlot({
        n <- input$n
        mua <- input$mua
        mu0 <- input$mu0
        sigma <- input$sigma
        alpha <- input$alpha
        myplot(n, mua, mu0, sigma, alpha)
    })
})