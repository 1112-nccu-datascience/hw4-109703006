library(FactoMineR)
library(ca)
data(iris)

model <- kmeans(iris[, 1:4], centers = 4)
cmodel3 <- ca::ca(table(iris$Species, model$cluster), nd = 4)
plot(cmodel3,
    mass = TRUE, contrib = "absolute", map =
        "rowgreen", arrows = c(FALSE, TRUE)
)
