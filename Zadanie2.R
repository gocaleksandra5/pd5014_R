Ekspresja <- matrix(runif(12, 1, 10), nrow = 3, ncol = 4)
rownames(Ekspresja) <- c("Gen1", "Gen2", "Gen3")
colnames(Ekspresja) <- c("Probka1", "Probka2", "Probka3", "Probka4")
Ekspresja

Ekspresja["Gen1", "Probka4"]

trzeci_wiersz <- Ekspresja[3, ]
druga_kolumna <- Ekspresja[, 2]
trzeci_wiersz
druga_kolumna

srednia_geny <- rowMeans(Ekspresja)
srednia_geny

srednia_probki <- colMeans(Ekspresja)
srednia_probki

# Transpozycja macierzy
EkspresjaT <- t(Ekspresja)
EkspresjaT

# Nowa macierz tylko dla Probki1 i Probki3
Ekspresja_13 <- Ekspresja[, c("Probka1", "Probka3")]
Ekspresja_13