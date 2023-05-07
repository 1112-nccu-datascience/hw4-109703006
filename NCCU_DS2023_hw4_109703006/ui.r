library(ggvis)
library(shiny)

# shinyUI(pageWithSidebar(
#     div(),
#     sidebarPanel(
#         sliderInput("n", "Number of points",
#             min = 1, max = nrow(mtcars),
#             value = 10, step = 1
#         ),
#         uiOutput("plot_ui")
#     ),
#     mainPanel(
#         ggvisOutput("plot"),
#         tableOutput("mtc_table")
#     )
# ))

shinyUI(pageWithSidebar(
    div(),
    sidebarPanel(
        includeHTML("./html/test2.html")
    ),
    mainPanel(
        includeHTML("./html/test.html")
    )
))