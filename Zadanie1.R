#suma 
A+B
#odejmowanie 
A-B
#mnożenie 
A*B
#dzielenie
A/B
#policzenie znaków 
nchar(C)
#trzeci element w C
C[3]
#Pierwszy i czwarty element
C[c(1,4)]
#posortowane wektory
sort(C)
#odwrócona kolejność
rev(C)
#przekształcenie w factor
C_factor <- factor(C)
#poziomy
levels(C_factor)
#liczba poziomów
nlevels(C_factor)
#Zmiana kolejności poziomów aby RNA było pierwsze 
C_factor <- factor(C_factor, levels = c("RNA", "ssDNA", "dsDNA", "Proteins", "Lipids"))
levels(C_factor)
#suma elementów
sum(D)
#numery indeksów dla TRUE
which(D)
#negacja wartości wektora D
!D
