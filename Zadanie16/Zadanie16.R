library(readr)
library(dplyr)

base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"
df <- read_csv(paste0(base_url, "rna_seq_data.csv"))

summary(df)

meanE <- mean(df$Expression_Level)
cat("Średnia wartość:", meanE, "\n")

medianE <- median(df$Expression_Level)
cat("Mediana:", medianE, "\n")

minE <- min(df$Expression_Level)
cat("Minimalna wartość:", minE, "\n")

maxE <- max(df$Expression_Level)
cat("Maksymalna wartość:", maxE, "\n")

sd(df$Expression_Level)
cat("Kwantyle:\n")

quantile(df$Expression_Level)


#Funkcja aggregate

print(aggregate(Expression_Level ~ Condition, df, mean))
print(aggregate(Expression_Level ~ Condition, df, median))
print(aggregate(Expression_Level ~ Condition, df, sd))
print(aggregate(Expression_Level ~ Condition, df, min))
print(aggregate(Expression_Level ~ Condition, df, max))

library(moments)
#Skosność
skewnessE <- skewness(df$Expression_Level)
cat("Skewness:", skewnessE, "\n")

#Kurtoza
kurtosisE <- kurtosis(df$Expression_Level)
cat("Kurtosis:", kurtosisE, "\n")

# Histogramy
hist(df$P_value, 
     main = "Histogram P_value",
     xlab = "P_value wartości",
     ylab = "Wartośći",
     col = "lightblue")

hist(df$Log2FC, 
     main = "Histogram Log2FC", 
     xlab = "Log2FC wartości",
     ylab = "Wartośći",
     col = "darkred")

#10 genów 
df_extreme <- df %>%
  arrange(desc(abs(Log2FC))) %>%
  head(10)

print(df_extreme)

#tabela 
table(df$Gene_Type)
table(df$Chromosome, df$Condition)

#Istotne geny
sink("significant_genes_stats.txt")

Istotne_geny<- df %>%
  filter(P_value < 0.05)

mean_ist <- mean(abs(Istotne_geny$Log2FC))
cat("Średnia log2FC dla istotnych genów to:", mean_ist, "\n")

najwyższa_ekspresja <- Istotne_geny %>%
  arrange(desc(Log2FC)) %>%
  head(5)
print(najwyższa_ekspresja)

najniższa_ekspesja <- Istotne_geny %>%
  arrange(Log2FC) %>%
  head(5)
print(najniższa_ekspesja)

sink()

#Nie wyświetlały się wyniki zanalizy przez funkcje sink, którą zastosowałam do zapisania części 5, więc po prostu zamieściłam to jeszcze raz 
Istotne_geny<- df %>%
  filter(P_value < 0.05)

mean_ist <- mean(abs(Istotne_geny$Log2FC))
cat("Średnia log2FC dla istotnych genów to:", mean_ist, "\n")
print(najwyższa_ekspresja)
print(najniższa_ekspesja)
