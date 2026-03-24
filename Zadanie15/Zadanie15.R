library(dplyr)
library(readr)
library(ggplot2)

base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"
df <- read_csv(paste0(base_url, "rna_seq_data.csv"))

#ggplot 1
jpeg("ekspresja_boxplot.jpeg", width = 800, height = 600, quality = 100)

ggplot(df, aes(x = Condition, y = Expression_Level, fill = Chromosome)) +
  geom_boxplot() +
  labs(
    title = "Poziomy ekspresji genów w różnych warunkach",
    x = "Warunek",
    y = "Poziom ekspresji") +
  
  theme_minimal()

dev.off()



#ggplot 2
jpeg("volcano.jpeg", width = 800, height = 600, quality = 100)

df <- df %>%
  mutate(
    log10 = -log10(P_value),
    istotność = ifelse(Adjusted_P_value < 0.05 & abs(Log2FC) > 1, "istotne", "nieistotne")
  )

ggplot(df, aes(x = Log2FC, y = log10, color = istotność)) +
 geom_point(alpha = 0.7, size = 2) +
  scale_color_manual(values = c("nieistotne" = "red", "istotne" = "blue")) +
  labs(
    title = "Analiza różnicowej ekspresji genów",
    x = "Log2 fold change",
    y = "-log10(p-value)"
  ) +
  theme_minimal() +
  
#Linie  
  geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed")

dev.off()

