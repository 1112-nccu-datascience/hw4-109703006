library(shiny)

ui <- fluidPage(
    fluidRow(
        navbarPage(
            title = "資科三 109703006 王世揚",
            # PCA
            tabPanel(
                "PCA",
                fluidRow(column(5, h3("PCA"))),
                sidebarLayout(
                    sidebarPanel(
                        fluidRow(
                            column(
                                3,
                                # choice x axis
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
                                # choice y axis
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
                    # draw plot
                    mainPanel(
                        plotOutput("plot1")
                    )
                )
            ),
            # CA
            tabPanel(
                "CA",
                fluidRow(column(5, h3("CA (use kmeans)"))),
                # side bar
                sidebarLayout(
                    sidebarPanel(
                        sliderInput("center_val", "center(k)",
                            min = 3, max = 10,
                            value = 3, step = 1
                        )
                    ),
                    # draw plot
                    mainPanel(
                        plotOutput("plot2")
                    )
                )
            )
        )
    )
)
