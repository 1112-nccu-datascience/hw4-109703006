library(ggvis)
library(shiny)

ui <- fluidPage(
    fluidRow(
        navbarPage(
            title = "資科三 109703006 王世揚",
            tabPanel(
                "PCA",
                fluidRow(column(5, h3("PCA"))),
                sidebarLayout(
                    sidebarPanel(
                        fluidRow(
                            column(
                                3,
                                radioButtons(
                                    "x_choice",
                                    label = "x axis:",
                                    choices = c(
                                        "PC1" = "1",
                                        "PC2" = "2",
                                        "PC3" = "3",
                                        "PC4" = "4"
                                    ),
                                    selected = "1"
                                )
                            ),
                            column(
                                3,
                                radioButtons(
                                    "y_choice",
                                    label = "y axis:",
                                    choices = c(
                                        "PC1" = "1",
                                        "PC2" = "2",
                                        "PC3" = "3",
                                        "PC4" = "4"
                                    ),
                                    selected = "2"
                                )
                            )
                        )
                    ),
                    mainPanel(
                        plotOutput("plot1")
                    )
                )
            ),
            tabPanel(
                "CA",
                fluidRow(column(5, h3("CA (use kmeans)"))),
                sidebarLayout(
                    sidebarPanel(
                        sliderInput("center_val", "center(k)",
                            min = 3, max = 10,
                            value = 3, step = 1
                        )
                    ),
                    mainPanel(
                        plotOutput("plot2")
                    )
                )
            ),
            tabPanel("tab 3", "contents"),
        )
    )
    # ))
)
