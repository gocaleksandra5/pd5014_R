gene_expression <- matrix(
                          rnorm(20, mean=10, sd=2),
                          nrow = 4, # 4 geny
                          ncol = 5, # 5 próbek
                          dimnames = list(
                                          
                                          c("Gen_A", "Gen_B", "Gen_C", "Gen_D"),
                                          
                                          c("Próbka_1", "Próbka_2", "Próbka_3", "Próbka_4", "Próbka_5")
                          )
)

gene_expression

apply(gene_expression, 1, mean)
apply(gene_expression, 2, sd)
apply(gene_expression, 1, max)
apply(gene_expression, 2, function(x) sum(x > 10))
