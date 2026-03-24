library(dplyr)
library(readr)

base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"
df <- read_csv(paste0(base_url, "rna_seq_data.csv"))


jpeg("histogram_ekspresji.jpeg", width = 800, height = 600, quality = 100)


hist(df$Expression_Level,
     main = "Rozkład poziomów ekspresji genów",
     xlab = "Poziom ekspresji",
     ylab = "Częstość",
     col = "pink",
)

dev.off()

jpeg("zmiana_ekspresji.jpeg", width = 800, height = 600, quality = 100)


df <- df %>%
  mutate(
    log10 = -log10(P_value),
    istotnosc = ifelse(Adjusted_P_value < 0.05, "istotny", "nieistotna")
  )

plot(df$Log2FC, df$log10,
     main = "Zmiana ekspresji vs Istotność statystyczna",
     xlab = "Log2 fold change", 
     ylab = "-log10 (p-value)",
     pch = 21,
     bg = ifelse(df$istotnosc == "istotny", "red", "blue")
)

dev.off()
