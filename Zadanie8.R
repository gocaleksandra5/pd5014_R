library(stringr)

base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"

sekwencje <- read.table(
  paste0(base_url, "sekwencje.txt"),
  header = TRUE,
  stringsAsFactors = FALSE
)

sekwencje <- sekwencje %>%
  mutate(
#Liczba wystąpień ATG
    ATG_count = str_count(Sekwencja, "ATG"),
    
#Zamiana RNA na DNA
    Sekwencja_DNA = str_replace_all(Sekwencja, "U", "T"),
    
#Pierwsze 10 nukleotydów
    Pierwsze10nukleotydów = str_sub(Sekwencja, 1, 10),
    
#Motyw GAG
    Motyw_GAG = str_detect(Sekwencja, "GAG")
  )


komplement <- function(seq, typ) {
  if (typ == "DNA") {
    return(chartr("ATGC", "TACG", seq))
  } else {
    return(chartr("AUGC", "UACG", seq))
  }
}

sekwencje$Sekwencja_rev <- mapply(komplement, sekwencje$Sekwencja, sekwencje$Typ)

podsumowanie <- sekwencje %>%
  mutate(
    Ostatnie5nukleotydów = str_sub(Sekwencja, -5, -1),
    GAG_info = ifelse(Motyw_GAG, "PRAWDA", "FAŁSZ")
  ) %>%
  select(
    ID,
    Pierwsze10nukleotydów,
    Ostatnie5nukleotydów,
    GAG_info
  )

sekwencje
podsumowanie
