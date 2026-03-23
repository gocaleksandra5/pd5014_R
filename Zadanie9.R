library(dplyr)
library(readr)


base_url <- "https://raw.githubusercontent.com/gocaleksandra5/pd5014_R/main/"
df <- read_csv(paste0(base_url, "rna_seq_data.csv"))


result <- df %>%
  
  filter(P_value < 0.05) %>%
  filter(Sample_Quality == "high") %>%
  select(Gene_Symbol, Expression_Level, Log2FC, Gene_Type) %>%
  group_by(Gene_Type) %>%
  

  summarise(
    mean_expression = mean(Expression_Level, na.rm = TRUE),
    ilość_genów = n()
  ) %>%
  
#sotowanie
  arrange(desc(mean_expression))


print(result)