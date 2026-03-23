base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"

pacjenci <- read.csv(
  paste0(base_url, "pacjenci.csv"),
  stringsAsFactors = FALSE,
  na.strings = "NA"
)

print(pacjenci)
  
library(dplyr)
library(naniar)
library(readr)


#Liczba NA w każdej kolumnie
colSums(is.na(pacjenci))

#Wizualizacja braków
vis_miss(pacjenci)

kompletne_badania_krwi <- pacjenci %>%
  filter(complete.cases(.))

#Uzupełnianie braków
pacjenci <- pacjenci %>%
  mutate(
    Hemoglobina = ifelse(
      is.na(Hemoglobina),
      ave(Hemoglobina, Płeć, FUN = function(x) mean(x, na.rm = TRUE)),
      Hemoglobina
    ),
    Leukocyty = ifelse(
      is.na(Leukocyty),
      median(Leukocyty, na.rm = TRUE),
      Leukocyty
    ),
    Płytki_krwi = ifelse(
      is.na(Płytki_krwi),
      ave(Płytki_krwi, Płeć, FUN = function(x) mean(x, na.rm = TRUE)),
      Płytki_krwi
    ),
    Stan = ifelse(
      is.na(Stan),
      names(sort(table(Stan), decreasing = TRUE))[1],
      Stan
    ),
    Palenie = ifelse(
      is.na(Palenie) | Palenie == "",
      "Brak danych",
      Palenie
    )
  )

print(pacjenci)
