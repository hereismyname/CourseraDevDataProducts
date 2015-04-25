library(shiny)
library(ggplot2)

shinyServer(function(input, output){
    
    output$plotfun <- renderPlot({
        
        n <- input$n
        mua <- input$mua
        mu0 <- input$mu0
        sigma <- input$sigma
        alpha <- input$alpha
        
        numtest <- c(n, mua, mu0, sigma, alpha)
        
        if (is.numeric(numtest) == FALSE) stop("It appears that one of your values is not a number! Please double-check to make sure your inputs are correct!")
        if (anyNA(numtest) == TRUE) stop("It appears you're missing a parameter!")                                       
        
        if (mua >= mu0) {
            xitc <- mu0 + qnorm(1 - alpha) * (sigma / sqrt(n))
            
            g <- ggplot(data.frame(axis = c(mu0 - (sigma / 2), mua + (sigma / 2))),
                        aes(x = axis))
            
            g <- g + stat_function(fun = dnorm, geom = "line", linetype = "dotdash",
                                   args = list(mean = mu0, 
                                               sd = sigma / sqrt(n)),
                                   size = 2, aes(color = "a")) +
                
                stat_function(fun = dnorm, geom = "line", linetype = "dotdash",
                              args = list(mean = mua, 
                                          sd = sigma / sqrt(n)),
                              size = 2, aes(color = "b")) +
                
                geom_vline(xintercept = xitc, size = 1.5, linetype = "dashed") +
                
                ggtitle("Power to detect difference across groups") +
                
                scale_colour_manual("Legend", 
                                    values = c("a" = "red",
                                               "b" = "blue"),
                                    labels = c("Control", "Experiment"))
            
        } else {
            
            if (mua < mu0) {
                xitc <- mu0 - qnorm(1 - alpha) * (sigma / sqrt(n))
                
                g <- ggplot(data.frame(axis = c(mua - (sigma / 2), mu0 + (sigma /2))),
                            aes(x = axis))
                
                g <- g + stat_function(fun = dnorm, geom = "line", linetype = "dotdash",
                                       args = list(mean = mu0, 
                                                   sd = sigma / sqrt(n)),
                                       size = 2, aes(color = "a")) +
                    
                    stat_function(fun = dnorm, geom = "line", linetype = "dotdash",
                                  args = list(mean = mua, 
                                              sd = sigma / sqrt(n)),
                                  size = 2, aes(color = "b")) +
                    
                    geom_vline(xintercept = xitc, size = 2) +
                    
                    ggtitle("Power to detect difference across groups") +
                    
                    scale_colour_manual("Legend", 
                                        values = c("a" = "red",
                                                   "b" = "blue"),
                                        labels = c("Control", "Experiment"))
                
            }
        }
        
        test <- power.t.test(n, delta = abs(mua - mu0), sd = sigma,
                             type = "one.sample", alt = "one.sided")$power
        
        test <- round(test, 2)
        
        test <- paste("Power to detect an effect: ", test, sep = "")
        
        es <- round(abs(mua - mu0) / sigma, 2)
        
        es <- paste("Approx. effect-size: ", es)
        
        print(g + theme(axis.title.y = element_blank(), 
                        panel.background = element_blank()) +
                  xlab("Means") + 
                  annotate("text", x = mu0 - 1, y = .25, label = test) +
                  annotate("text", x = mu0 - 1, y = .20, label = es) +
                  annotate("text", x = xitc - .5, y = 0, label = "Alpha")
              )
    })
})