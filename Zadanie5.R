
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

download.file(
  paste0(base_url, "geny.xlsx"),
  destfile = "geny.xlsx",
  mode = "wb"
)

geny <- read_excel("geny.xlsx")

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

str(geny)
head(geny)
dim(geny)

pacjenci$BMI_kategoria <- ifelse(pacjenci$BMI > 25, "Nadwaga", "OK")

sekwencje$Długość_seq <- nchar(sekwencje$Sekwencja)

geny$Istotne <- ifelse(geny$P_value < 0.05, "tak", "nie") 

write.csv(pacjenci, "pacjenci_new.csv", row.names = FALSE)
write.csv(sekwencje, "sekwencje_new.csv", row.names = FALSE)
write.csv(geny, "geny_new.csv", row.names = FALSE)

saveRDS(pacjenci, "pacjenci.rds")
saveRDS(sekwencje, "sekwencje.rds")
saveRDS(geny, "geny.rds")

write.table(pacjenci, "pacjenci.txt", sep = "\t", row.names = FALSE)
write.table(sekwencje, "sekwencje.txt", sep = "\t", row.names = FALSE)
write.table(geny, "geny.txt", sep = "\t", row.names = FALSE)



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




