#install.packages("ggplot2")
library("ggplot2")

df <- as.data.frame(matrix(c(30, 29, 24, 27, 26, 22, 37, 22, 42, 10, 7, 41, 21, 20, 30, 32, 24, 20, 4, 32,
                             4.8, 4.1, 3.9, 4.4, 5.5, 3.9, 7.1, 3.7, 19.8, 11.5, 2.4, 7.52, 2.83, 4.1, 4.7, 2.9, 5, 4.3, 2.3, 2.9,
                             18, 17, 17, 14, 16, 14, 17, 17, 14, 20, 20, 18, 18, 20, 18, 15, 15, 20, 19, 15,
                             269, 379, 349, 299, 299, 160, 499, 259, 2699, 419, 269, 489, 189, 369, 319, 399, 200, 269, 159, 419), 20, 4))
labels <- c("1", "2", "3", "4", "5")
result <- c(2, 3, 4, 3, 3, 5, 3, 3, 1, 3, 3, 3, 3, 4, 2, 3, 1, 5, 3, 3)
factors <- factor(result, labels)
df <- cbind(df, factors)
colnames(df) <- c("Pojemnosc", "Waga_w_kg", "Utrzymywanie_temperatury_do_st_c", "Cena", "Ocena")

stripchart <- ggplot(df, aes(Utrzymywanie_temperatury_do_st_c, Cena, col = factor(Ocena))) + geom_jitter(position = position_jitter(width = 0.2), size=5)
stripchart <- stripchart + ylab("Cena") + xlab("Utrzymywanie_temperatury_do_st_c") + labs(colour = "Ocena")
stripchart <- stripchart + ggtitle("Porownanie lodowek turystycznych") + theme(plot.title = element_text(vjust =+ 2))
stripchart
