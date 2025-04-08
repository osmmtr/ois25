# Chargement des packages nécessaires
library(ggplot2)
library(dplyr)

# Génération de données simulées : croissance de plantes selon lumière et engrais
set.seed(123)
data <- expand.grid(
  Jour = 1:30,
  Lumiere = c("Faible", "Modérée", "Forte"),
  Engrais = c("A", "B")
)

data$Croissance <- with(data, 
  ifelse(Lumiere == "Forte", Jour * runif(nrow(data), 0.5, 1),
  ifelse(Lumiere == "Modérée", Jour * runif(nrow(data), 0.3, 0.7),
         Jour * runif(nrow(data), 0.1, 0.4)))
)
data$Croissance <- data$Croissance + ifelse(data$Engrais == "B", rnorm(nrow(data), 3, 2), 0)

# Création de la visualisation
ggplot(data, aes(x = Jour, y = Croissance, color = Lumiere)) +
  geom_line() +
  facet_wrap(~ Engrais) +
  labs(
    title = "Croissance des plantes selon la lumière et l'engrais",
    subtitle = "Simulation sur 30 jours",
    x = "Jour",
    y = "Taille de la plante (cm)",
    color = "Intensité lumineuse"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "top"
  )
