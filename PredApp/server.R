library(shiny)
library(datasets)


data(faithful)
model <- lm(eruptions ~ waiting, data = faithful)

shinyServer(
    function(input, output) {
        output$out_wait_time <- renderPrint({input$in_wait_time})   
        wait <- reactive({
            validate(
                need((input$in_wait_time <= 96) & (input$in_wait_time >= 43), "Entered waiting time off limits !")
            )
            input$in_wait_time
        })
        pred <- reactive({predict(model, data.frame(waiting = wait()))[[1]]})
        output$prediction <- renderPrint({pred()})
        output$lm <- renderUI({
            checkboxInput("regline", em("Show regression line"), FALSE)
            })
        output$semiTrans <- renderUI({
            if(transparency()) if(input$points) sliderInput("trans", em("Choose transparency level"), 10, 90, 40, step = 10)
            })
        transparency <- reactive({
            trans <- FALSE
            if (length(input$regline)) if (input$regline) trans <- TRUE
            trans
            })
        semi.trans <- reactive({
            if (length(input$trans) == 0) 40
            else input$trans
        })
        output$reg_plot <- renderPlot({
            par(mar = c(5.1, 4.1, 0, 2.1))
            plot(eruptions ~ waiting, data = faithful, type = "n", xlab = "Waiting time to next eruption (in mins)", ylab = "Eruption duration (in mins)")
            points(wait(), pred(), col = "red", pch = 19)
            segments(wait(), 0, wait(), pred(), col = "red", lty = 2)
            segments(0, pred(), wait(), pred(), col = "red", lty = 2)
            text(40, pred(), round(pred(), digits = 2), adj = c(-0.5,-0.5), col = "red")
            text(wait(), 1.5, round(wait(), digits = 2), adj = c(-0.5, 0), col = "red")
            if (length(input$points)) {
                if (input$points) {
                    if (transparency()) {
                        points(faithful$waiting, faithful$eruptions, col = paste("#000000", 100 - semi.trans(), sep = "", collapse = ""), pch = 2)
                        } else {
                            points(faithful$waiting, faithful$eruptions, pch = 2)       
                            }
                    }
                }
            if (length(input$regline)) if(input$regline) abline(model, col = "blue")
        })
    }
)