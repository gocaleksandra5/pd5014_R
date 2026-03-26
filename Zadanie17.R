data(npk)

head(npk)
str(npk)
summary(npk)

#Anowa

anova_N <- aov(yield ~ N, data = npk)
summary(anova_N)

anova_P <- aov(yield ~ P, data = npk)
summary(anova_P)

anova_K <- aov(yield ~ K, data = npk)
summary(anova_K)

anova_block <- aov(yield ~ block, data = npk)
summary(anova_block)

#Test post-hoc Tukeya

tukey_N <- TukeyHSD(anova_N)
tukey_N

tukey_P <- TukeyHSD(anova_P)
tukey_P

tukey_K <- TukeyHSD(anova_K)
tukey_K

#test Kruskala-Wallisa

kruskal.test(yield ~ N, data = npk)

kruskal.test(yield ~ P, data = npk)

kruskal.test(yield ~ K, data = npk)

kruskal.test(yield ~ block, data = npk)

#Regresja liniowa 

model <- lm(yield ~ N + P + K + block, data = npk)
summary(model)

model2 <- lm(yield ~ P, data = npk)
summary(model2)

model3 <- lm(yield ~ K, data = npk)
summary(model3)

model4 <- lm(yield ~ block, data = npk)
summary(model4)

