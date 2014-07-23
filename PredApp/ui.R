library(shiny)

shinyUI(navbarPage(fluid = FALSE, em("Duration of Old Faithful geyser eruption"),
    tabPanel("Application",
        titlePanel(title = strong(em("Prediction of the duration of the eruption of Old Faithful geyser in Yellowstone National Park, Wyoming, USA")), windowTitle = "Prediction of eruption of Old Faithful geyser"),
        sidebarLayout(
            sidebarPanel(
                h4("Waiting time to next eruption"),
                numericInput("in_wait_time", "Enter the desired waiting time (in mins)", 70, min = 43, max = 96, step = 1),
                p(),
                submitButton("Submit")
                ),
            mainPanel(
                h4("Waiting time entered (in mins) :"),
                verbatimTextOutput("out_wait_time"),
                h4("Prediction of eruption duration (in mins) :"),
                verbatimTextOutput("prediction"),
                h4("Plot of eruption duration vs waiting time to next eruption :"),
                plotOutput("reg_plot")
                )
            )
        ),
    tabPanel("Documentation",
            titlePanel(title = strong(em("Prediction of the duration of the eruption of Old Faithful geyser in Yellowstone National Park, Wyoming, USA")), windowTitle = "Prediction of eruption of Old Faithful geyser"),
            h4("Synopsis"),
            p("This application predicts the duration of an eruption as a linear function of the waiting time to the next eruption. The linear function is simply the regression line of the duration of the eruption vs the waiting time to the next eruption."),
            h4("How it works"),
            p("You have to enter a waiting time (in minutes) to the next eruption in the left-hand panel and then click on the Submit button. The waiting times entered must be between 43 mins and 96 mins to avoid extrapolation. If this is not the case the application will display the error message : Entered waiting time off limits !"),
            h4("Results"),
            p("The predicted duration of the eruption (in minutes) obtained from the waiting time entered will be displayed in the main panel as will be a reminder of the waiting time entered."),
            p("Below you will also find a plot of eruption duration vs waiting time to next eruption. The regression line used for predicting the duration is also displayed (in blue) as are the coordinates of the prediction (in red).")
        )
    )
)