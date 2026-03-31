#Część 1. użyłam danych z przedmiotu statystyka z poprzedniego semestru. 

#dane pobrałąm ze strony:
#kod do wyszukania badań :GSE101521
#Badanie miało na celu analizę genów w grzbietowo-bocznej korze przedczołowej mózgu, które są aktywne podczas myśli samobujczych. 
#Kontrole stanowiły osoby bez myśli samobujczych a badawczą osoby, które doświadczały myśli samobujczych i depresji. 

base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"

library(readxl)
library(dplyr)

download.file(
  paste0(base_url, "CON%20VS%20MDD.xlsx"),
  destfile = "CON_VS_MDD.xlsx",
  mode = "wb"
)

geny <- read_excel("CON_VS_MDD.xlsx")

#Struktura danych
str(geny)

#Wymiary (wiersze, kolumny)
dim(geny)

#Pierwsze 10 wierszy
head(geny, 10)

#Ostatnie 5 wierszy
tail(geny, 5)

#Część 2. 
#Sprawdzenie NA
colSums(is.na(geny))

#Dodanie przykładowych NA (są w pliku, ale nie byłam pewna czy i tak nie trzeba dodać NA w ramach zadania)
geny[1, 1] <- NA
geny[1, 2] <- NA
geny[1, 3] <- NA

# Usunięcie NA
geny_BEZ_NA <- na.omit(geny)

#Tabela bez NA
colSums(is.na(geny_BEZ_NA))

#Przekształcenie danych na factor
geny_BEZ_NA$Symbol <- as.factor(geny_BEZ_NA$Symbol)

#Duże litery 
colnames(geny_BEZ_NA) <- toupper(colnames(geny_BEZ_NA))

#sortowanie LOG2FOLDCHANGE
geny_posortowane <- geny_BEZ_NA[order(-geny_BEZ_NA$LOG2FOLDCHANGE), ]

#Tylko warośći większe od >0,05 czyli statystycznie mające znaczenie 
geny_przefiltrowane <- geny_posortowane[geny_posortowane$PVALUE > 0.05, ]
head(geny_przefiltrowane)

#Część 3 
# Sprawdzenie braków
colSums(is.na(geny))

# Zamiana NA na średnią 
geny_srednie <- geny

num_cols <- sapply(geny_srednie, is.numeric)

geny_srednie[num_cols] <- lapply(geny_srednie[num_cols], function(x) {
  x[is.na(x)] <- mean(x, na.rm = TRUE)
  return(x)
})

head(geny_srednie)


#Część 4 .funkcje 
#Filtrowanie
filtered <- geny_srednie %>%
  filter(padj < 0.05)

#Wybór kolumn
selected <- geny_srednie %>%
  select(GeneID, log2FoldChange, baseMean)

#Modyfikacja
modified <- geny_srednie %>%
  mutate(high_expression = baseMean > mean(baseMean))

#Suma 
sorted <- geny_srednie %>%
  arrange(desc(log2FoldChange))

geny_srednie %>%
  summarise(
    srednia = mean(log2FoldChange),
    odchylenie = sd(log2FoldChange),
    minimum = min(log2FoldChange),
    maksimum = max(log2FoldChange)
  )

#Część 5 Statystyki

summary(geny_srednie)

num_cols <- sapply(geny_srednie, is.numeric)

statystyki <- data.frame(
  min = sapply(geny_srednie[num_cols], min),
  max = sapply(geny_srednie[num_cols], max),
  mean = sapply(geny_srednie[num_cols], mean),
  median = sapply(geny_srednie[num_cols], median),
  sd = sapply(geny_srednie[num_cols], sd)
)

statystyki

table(geny_srednie$Symbol)

#Część 6. T-student
#żeby porównać dwie grupy pobrałam kolejną grupę kontrole vs osoby po próbach samobujczych 
#pierwszy plik zawierał grupy kontrola vs osoby z depresją
#nie było też w tych plikach danych które były by odpowiednie do testu t-student więc dodałam kolumne o naziw epoziom ekspresji genów i wygenerowałam losowe liczby. 

download.file(
  paste0(base_url, "CON%20VS%20MDD-S.xlsx"),
  destfile = "CON_VS_MDD-S.xlsx",
  mode = "wb"
)

geny.nr.2 <- read_excel("CON_VS_MDD-S.xlsx")

geny <- geny %>%
  mutate('Poziom ekspresji genów' = 
           runif(n()))
geny.nr.2 <- geny %>%
  mutate('Poziom ekspresji genów' = 
           runif(n()))

x <- geny$`Poziom ekspresji genów`
y <- geny.nr.2$`Poziom ekspresji genów`
t.test(x, y)

#Moje wyniki: 

#t = 0.32365, df = 43195, p-value = 0.7462
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.004545716  0.006343856
#sample estimates:
#  mean of x mean of y 
#0.5016605 0.5007615 

#p-value oznacza że u mnie brak jest istostnej różnicy między grupami
#różnica średnich jest minimalna 
#przedział ufności 95% potwierdza brak istotności 



#Część 7. Wykresy 

library(ggplot2)
library(dplyr)

geny_srednie <- geny_srednie %>%
  mutate(group = ifelse(log2FoldChange > 2, "high", "low"))

posortowane <- geny_srednie %>%
  arrange(desc(log2FoldChange))

# Histogram
ggplot(geny_srednie, aes(x = log2FoldChange)) +
  geom_histogram(fill = "pink", bins = 30) +
  labs(title = "Rozkład log2FoldChange")

#Wykres pudełkowy
ggplot(geny_srednie, aes(x = group, y = log2FoldChange)) +
  geom_boxplot(fill = "pink") +
  labs(title = "Porównanie grup")

# Wykres liniowy
ggplot(head(posortowane, 20),
       aes(x = reorder(Symbol, log2FoldChange),
           y = log2FoldChange,
           group = 1)) +
  geom_line() +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Top 20 genów")


#Część nr.8 
#Zrobłam fukcje, która sortuje po istotności 0.05
filter_genes <- function(geny, padj_threshold = 0.05, lfc_threshold = 1) {
  
  filtered <- geny[
    !is.na(geny$padj) &
      geny$padj < padj_threshold &
      abs(geny$log2FoldChange) > lfc_threshold,
  ]
  filtered <- filtered[order(filtered$padj), ]
  
  return(filtered)
}

geny_filtered <- filter_genes(geny)

head(geny_filtered)

#Część nr.9 
To jeszcze dokończę
