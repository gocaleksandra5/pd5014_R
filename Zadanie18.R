library(GenomicRanges)

regiony_wiazania <- GRanges(
  seqnames = c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6"),
  ranges = IRanges(
    start = c(100, 500, 200, 700, 100, 900),
    end = c(200, 650, 400, 950, 450, 1200)
  ),
  strand = c("+", "-", "+", "-", "+", "-"),
  gene_name = c("GeneA", "GeneB", "GeneC", "GeneD", "GeneE", "GeneF"),
  expression = c(5.2, 3.8, 7.1, 2.5, 6.0, 4.3))

print(regiony_wiazania)


#Długość regionu
width(regiony_wiazania)

#Wyodrębnienie konkretnego regionu 
subset_chr1 <- subset(regiony_wiazania, seqnames == "chr1")
subset_chr1

#Tabela
table(seqnames(regiony_wiazania))
