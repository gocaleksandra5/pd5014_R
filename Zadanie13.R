bakterie <- 100
koniec <- 100000

godzina <- 0
maksymalnyczas <- 10

while (godzina < maksymalnyczas && bakterie <= koniec) {
  
  godzina <- godzina + 1
  poprzednia_liczba <- bakterie
  bakterie <- bakterie * 2
  
  
  wzrost <- bakterie - poprzednia_liczba
  suma_wzrostu <- suma_wzrostu + wzrost
  
  
  cat("Aktualna godzina:", godzina)
  cat("Liczba bakterii:", bakterie)
  cat("Wzrost o", wzrost, "bakterii od poprzedniej godziny\n\n")
  
  
  if (bakterie > koniec) {
    cat("Przekroczono limit zatrzymanie symulacji.\n\n")
    break
  }
}

suma_wzrostu <- 0
sredni_wzrost <- suma_wzrostu / godzina


cat("Czas trwania symulacji:", godzina, "godzin")
cat("Końcowa liczba bakterii:", bakterie)
cat("Średni wzrost na godzinę:", sredni_wzrost)