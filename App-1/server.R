library(shiny)
library(ggplot2)

shinyServer(function(input, output){
    
    output$plotfun <- renderPlot({
        
        n <- input$n
        mua <- input$mua
        mu0 <- input$mu0
        sigma <- input$sigma
        alpha <- input$alpha
        
        xitc <- mu0 + qnorm(1 - alpha) * (sigma / sqrt(n))
        
        g <- ggplot(data.frame(axis = c(mu0 - (sigma / 2), mua + (sigma / 2))),
                    aes(x = axis))
        
        g <- g + stat_function(fun = dnorm, geom = "line", 
                               args = list(mean = mu0, 
                                           sd = sigma / sqrt(n)),
                               size = 2, col = "red") +
            
            stat_function(fun = dnorm, geom = "line",
                               args = list(mean = mua, 
                                           sd = sigma / sqrt(n)),
                               size = 2, col = "blue") +
            
            geom_vline(xintercept = xitc, size = 2) +
            
            ggtitle("Power to detect difference across groups")
        
        print(g)
    })
})