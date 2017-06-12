#install.packages("sets")
library("sets")

sets_options("universe", seq(1, 500, 0.5))
variables <- set(
  Pojemnosc = fuzzy_partition(varnames = c(mala = 1, srednia = 15, duza = 28), sd = 1.0),
  Waga_w_kg = fuzzy_partition(varnames = c(lekka = 0.5, srednia = 4.0, ciezka = 10.5), sd = 0.1),
  Utrzymywanie_temperatury_do_st_c = fuzzy_partition(varnames = c(znakomite = 15, wystarczajace = 17, slabe = 19), sd = 2.0),
  Cena = fuzzy_partition(varnames = c(niska = 0, srednia = 220, wysoka = 440), sd = 10),
  Ocena = fuzzy_partition(varnames = c(slaba = 1, przecietna = 2, niezla = 3, dobra = 4, swietna = 5), FUN = fuzzy_cone, radius = 0.5)
)

# Fuzzy rules
rules <- set(
  fuzzy_rule(Pojemnosc %is% mala && Waga_w_kg %is% lekka && Utrzymywanie_temperatury_do_st_c %is% slabe, Ocena %is% slaba),
  fuzzy_rule(Pojemnosc %is% mala && Waga_w_kg %is% lekka, Ocena %is% przecietna),
  fuzzy_rule(Pojemnosc %is% srednia && Waga_w_kg %is% srednia, Ocena %is% dobra),
  fuzzy_rule(Pojemnosc %is% duza && Waga_w_kg %is% ciezka, Ocena %is% swietna),
  fuzzy_rule(Cena %is% niska && Pojemnosc %is% mala && Waga_w_kg %is% lekka, Ocena %is% niezla),
  fuzzy_rule(Cena %is% srednia && Pojemnosc %is% srednia && Waga_w_kg %is% srednia, Ocena %is% dobra),
  fuzzy_rule(Cena %is% duza && Pojemnosc %is% duza && Waga_w_kg %is% ciezka, Ocena %is% swietna),
  fuzzy_rule(Cena %is% wysoka && Utrzymywanie_temperatury_do_st_c %is% znakomite, Ocena %is% niezla),
  fuzzy_rule(Cena %is% niska && Utrzymywanie_temperatury_do_st_c %is% slabe, Ocena %is% niezla),
  fuzzy_rule(Cena %is% niska && Utrzymywanie_temperatury_do_st_c %is% znakomite, Ocena %is% swietna),
  fuzzy_rule(Cena %is% wysoka && Utrzymywanie_temperatury_do_st_c %is% slabe, Ocena %is% slaba)
)
model <- fuzzy_system(variables, rules)

print(model)
plot(model)
example.1 <- fuzzy_inference(model, list(Pojemnosc = 32, Waga_w_kg = 2.9, Utrzymywanie_temperatury_do_st_c = 15, Cena = 419))
gset_defuzzify(example.1, "centroid")
dev.new()
plot(example.1)
