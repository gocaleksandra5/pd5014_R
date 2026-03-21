base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"

library(readxl)
library(dplyr)

download.file(
  paste0(base_url, "geny_1.xlsx"),
  destfile = "geny_1.xlsx",
  mode = "wb"
)

geny <- read_excel("geny_1.xlsx")

geny <- geny %>%

  mutate(
    Dlugosc_genu = End - Start,
    Kategoria_genu = cut(
      Dlugosc_genu,
      breaks = c(-Inf, 100000, 300000, Inf),
      labels = c("Krótki", "Średni", "Długi")
    ),
    Strand_binary = ifelse(Strand == "+", 1, -1),
    Data_odkrycia = as.Date(
      c("1990.12.15", "1979.04.22", "1983.06.10", "1986.09.05",
        "2002.03.18", "1997.11.30", "1995.08.12", "1988.07.25"),
      format = "%Y.%m.%d"
    ))

print(geny)
