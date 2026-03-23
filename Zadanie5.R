
base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"

#Pacjęci
pacjenci <- read.csv(
  paste0(base_url, "pacjenci.csv"),
  stringsAsFactors = FALSE,
  na.strings = "NA"
)

#Sekwencje
sekwencje <- read.table(
  paste0(base_url, "sekwencje.txt"),
  header = TRUE,
  stringsAsFactors = FALSE
)

#Geny
library(readxl)

geny <- read_excel("geny.xlsx")

Ekspresja_genow <- read_excel("geny.xlsx", sheet = "Ekspresja_genow")
Metadane <- read_excel("geny.xlsx", sheet = "Metadane")

#Białka
library(xml2)

download.file(
  paste0(base_url, "bialka.xml"),
  destfile = "bialka.xml"
)

bialka_xml <- read_xml("bialka.xml")


str(pacjenci)
head(pacjenci)
dim(pacjenci)

str(sekwencje)
head(sekwencje)
dim(sekwencje)

str(Ekspresja_genow)
head(Ekspresja_genow)
dim(Ekspresja_genow)


str(Metadane)
head(Metadane)
dim(Metadane)



pacjenci$BMI_kategoria <- ifelse(pacjenci$BMI > 25, "Nadwaga", "OK")

sekwencje$Długość_seq <- nchar(sekwencje$Sekwencja)

Ekspresja_genow$Istotne <- ifelse(Ekspresja_genow$P_value < 0.05, "tak", "nie") 

write.csv(pacjenci, "pacjenci_new.csv", row.names = FALSE)
write.csv(sekwencje, "sekwencje_new.csv", row.names = FALSE)
write.csv(Ekspresja_genow, "Ekspresja_genow_new.csv", row.names = FALSE)

saveRDS(pacjenci, "pacjenci.rds")
saveRDS(sekwencje, "sekwencje.rds")
saveRDS(Ekspresja_genow, "Ekspresja_genow.rds")

write.table(pacjenci, "pacjenci.txt", sep = "\t", row.names = FALSE)
write.table(sekwencje, "sekwencje.txt", sep = "\t", row.names = FALSE)
write.table(Ekspresja_genow, "Ekspresja_genow.txt", sep = "\t", row.names = FALSE)



library(biomaRt)

ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

gen_MTCO1 <- getBM(
  attributes = c(
    "ensembl_gene_id",
    "hgnc_symbol",
    "chromosome_name",
    "gene_biotype"),
  filters = "hgnc_symbol",
  values = "MT-CO1",
  mart = ensembl)


gen_MTCO1
