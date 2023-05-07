library(shiny)
library(ggvis)
library(ggbiplot)
library(FactoMineR)
library(factoextra)
library(ca)

server <- function(input, output) {
    data(iris)
    # log transform
    log.ir <- log(iris[, 1:4])
    ir.species <- iris[, 5]
    # apply PCA - scale. = TRUE is highly advisable, but default is FALSE.
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)
    choices <- c(1, 2)
    center_val <- 3

    observeEvent(c(input$x_choice, input$y_choice, input$center_val), {
        if (input$x_choice != input$y_choice) {
            choices <- c(as.integer(input$x_choice), as.integer(input$y_choice))
        }
        center_val <- as.integer(input$center_val)

        g <- ggbiplot(ir.pca,
            obs.scale = 1, var.scale = 1, groups = ir.species,
            choices = choices, ellipse = TRUE
        )
        g <- g + scale_color_discrete(name = "")
        g <- g + theme(legend.direction = "horizontal", legend.position = "top")

        model <- kmeans(iris[, 1:4], centers = center_val)
        cmodel3 <- ca::ca(table(iris$Species, model$cluster), nd = 4)
        ca <- fviz_ca(cmodel3,
            mass = TRUE, contrib = "absolute", map =
                "rowgreen", arrows = c(FALSE, TRUE)
        )

        output$plot1 <- renderPlot({
            g
        })
        output$plot2 <- renderPlot({
            ca
        })
    })
}
