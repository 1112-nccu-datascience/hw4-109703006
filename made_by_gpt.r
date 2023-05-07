# library(FactoMineR)
# library(factoextra)
# data(iris)
# # 將資料集轉換成頻率表格
# iris_freq <- as.data.frame(table(iris$Species, iris$Petal.Length))

# # 執行對應分析
# ca <- CA(iris_freq, graph = FALSE)

# # 將分析結果套用k-means演算法進行分群
# kmeans_ca <- kmeans(ca$col$coord, centers = 3, nstart = 25)

# # 將分群結果加入對應分析結果中
# ca$cluster <- as.factor(kmeans_ca$cluster)

# # 顯示分析結果
# ca
# # 畫出對應分析的散佈圖
# fviz_ca_biplot(ca, col.var = "black", col.cluster = "cluster")
# library(ggplot2)

# # 將資料集轉換成長格式
# iris_long <- reshape2::melt(iris, id.vars = "Species")

# # 畫出每一個分群的花瓣長度的分佈圖
# ggplot(iris_long, aes(x = value, fill = factor(kmeans_ca$cluster))) +
#     geom_density(alpha = 0.5) +
#     facet_wrap(~variable, scales = "free") +
#     labs(title = "Distribution of petal length by cluster")

library(shiny)
library(ggbiplot)
library(ca)

server <- function(input, output) {
    data(iris)
    # log transform
    log.ir <- log(iris[, 1:4])
    ir.species <- iris[, 5]
    # apply PCA - scale. = TRUE is highly advisable, but default is FALSE.
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)

    observeEvent(c(input$x_choice, input$y_choice, input$center_val), {
        # Get the indices of the selected x and y variables
        x_idx <- match(input$x_choice, names(iris[, 1:4]))
        y_idx <- match(input$y_choice, names(iris[, 1:4]))

        # Generate biplot using the selected x and y variables
        g <- ggbiplot(ir.pca,
            obs.scale = 1, var.scale = 1, groups = ir.species,
            choices = c(x_idx, y_idx), ellipse = TRUE
        ) +
            scale_color_discrete(name = "") +
            theme(legend.direction = "horizontal", legend.position = "top")

        # Perform kmeans clustering on the iris data using selected number of centers
        model <- kmeans(iris[, 1:4], centers = input$center_val)
        # Perform CA on the kmeans cluster results and the species data
        cmodel3 <- ca::ca(table(iris$Species, model$cluster), nd = 4)
        # Generate plot for the CA results
        ca_plot <- plot(cmodel3, mass = TRUE, contrib = "absolute", map = "rowgreen", arrows = c(FALSE, TRUE))

        # Update the plot outputs in the UI
        output$plot1 <- renderPlot({
            g
        })
        output$plot2 <- renderPlot({
            ca_plot
        })
    })
}

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("x_choice", "X Variable:", choices = names(iris[, 1:4])),
            selectInput("y_choice", "Y Variable:", choices = names(iris[, 1:4])),
            numericInput("center_val", "Number of centers for kmeans:", value = 3, min = 1, max = 10)
        ),
        mainPanel(
            plotOutput("plot1"),
            plotOutput("plot2")
        )
    )
)

shinyApp(ui, server)
