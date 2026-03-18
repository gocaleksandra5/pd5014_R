df <- data.frame(
                 ID = 1:5,
                 Wiek = c(25, 34, 28, 52, 40),
                 Płeć = c("Kobieta", "Mężczyzna", "Kobieta", "Mężczyzna", "Kobieta"),
                 Wzrost = c(165, 180, 170, 175, 168),
                 Waga = c(60, 80, 65, 75, 58),
                 Status_zdrowia = c("Dobry", "Średni", "Dobry", "Zły", "Dobry")
)
print(df)

#Podstawowe informacje 
str(df)
dim(df)
nrow(df)
ncol(df)
names(df)
rownames(df)
summary(df)
head(df, 3)

#Średni wiek pacientów 
sredni_wiek <- mean(df$Wiek)
sredni_wiek
#Tylko pacjęci ze statusem dobry i są kobietami
kobiety_dobry <- df[df$Status_zdrowia == "Dobry" & df$Płeć == "Kobieta", ]
kobiety_dobry

#sortowanie ramki wieku do malejącego
df_sorted <- df[order(-df$Wiek), ]
df_sorted

#maksmalny i minimalny wzrost
max_zrostu <- max(df$Wzrost)
max_zrostu
min_wzrosty <- min(df$Wzrost)
min_wzrosty

