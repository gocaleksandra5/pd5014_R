bio_lista <- list(
                  sekwencje_DNA = c("ATGCCTGAC", "GTCAGTCAG", "CTGATCGATGCTA"),
                  gatunki = c("Homo sapiens", "Mus musculus", "Drosophila melanogaster"),
                  ekspresja_genow = matrix(runif(9, 0, 100), nrow = 3),
                  cechy_morfologiczne = data.frame(
                                                   
                                                   Gatunek = c("Homo sapiens", "Mus musculus", "Drosophila melanogaster"),
                                                   
                                                   Wysokość = c(170, 10, 0.1),
                                                   
                                                   Waga = c(70, 0.02, 0.0002)
                  ),
                  mutacje = list(Homo_sapiens = c("BRCA1", "BRCA2"), Mus_musculus = "p53")
)
print(bio_lista)
#Podstawowe informacje
names(bio_lista)
#Nazwy gatunków 
bio_lista$gatunki
#nowa sekwencja 
bio_lista$sekwencje_DNA <- c(bio_lista$sekwencje_DNA, "CGATGTAGCTA")
#zmiana pierwszej wartości w macierzy
bio_lista$ekspresja_genow[1,1] <- 99.9
print(bio_lista)
#średnia ekspresja w macierzy
mean(bio_lista$ekspresja_genow)
#nowy gatunek
bio_lista$cechy_morfologiczne <- rbind(
  bio_lista$cechy_morfologiczne, data.frame(
    Gatunek = c("Arabidopsis thaliana"), 
    Wysokość = c(0.3), 
    Waga = c(0.001)
  )
)
bio_lista$cechy_morfologiczne

#Homo sapiens info
bio_lista$mutacje$Homo_sapiens
#nowa mutacja
bio_lista$mutacje$Mus_musculus <- c(bio_lista$mutacje$Mus_musculus, "Lmna")
bio_lista$mutacje
