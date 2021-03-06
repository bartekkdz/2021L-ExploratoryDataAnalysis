## Praca domowa 1
## Marcin Drzewiecki

## install.packages("PogromcyDanych")
library(PogromcyDanych)

## 1. Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?

auta2012 %>% 
  select(Rodzaj.paliwa, Rok.produkcji) %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>% 
  summarise(n())
  
## Odp: 11621


## 2) Jakiego koloru auta maja najmniejszy medianowy przebieg?

auta2012 %>% 
  select(Kolor, Przebieg.w.km) %>% 
  group_by(Kolor) %>% 
  summarise(medianowy.przebieg = median(Przebieg.w.km, na.rm=TRUE)) %>% 
  arrange(medianowy.przebieg)  %>% 
  head(1)

## Odp: bialy-metallic


## 3) Gdy ograniczyc sie tylko do aut wyprodukowanych w 2007, 
## kt�ra Marka wystepuje najczesciej w zbiorze danych auta2012?

auta2012 %>% 
  select(Marka, Rok.produkcji) %>% 
  filter(Rok.produkcji == 2007) %>% 
  group_by(Marka) %>% 
  summarize(cz�sto�� = n()) %>% 
  arrange(-cz�sto��) %>% 
  head(1)

## Odp: Volkswagen

## 4) Sposr�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najtansza?

auta2012 %>% 
  select(Rodzaj.paliwa, Rok.produkcji, Marka, Cena.w.PLN) %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>% 
  group_by(Marka) %>% 
  summarise(mediana.cena = mean(Cena.w.PLN)) %>% 
  arrange(mediana.cena) %>% 
  head(1)

## Odp: Aixam

## 5) Sposr�d aut marki Toyota, kt�ry model najbardziej stracil na cenie pomiedzy 
## rokiem produkcji 2007 a 2008?

Dane_Toyta2007 <- auta2012 %>% 
  select(Marka, Rok.produkcji, Model, Cena.w.PLN) %>% 
  filter(Marka == "Toyota", Rok.produkcji == 2007) %>% 
  select(Model, Cena.w.PLN) %>% 
  group_by(Model) %>% 
  summarise(�rednia.cena = mean(Cena.w.PLN, na.rm=TRUE))

Dane_Toyta2008 <- auta2012 %>% 
  select(Marka, Rok.produkcji, Model, Cena.w.PLN) %>% 
  filter(Marka == "Toyota", Rok.produkcji == 2008) %>% 
  select(Model, Cena.w.PLN) %>% 
  group_by(Model) %>% 
  summarise(�rednia.cena = mean(Cena.w.PLN, na.rm=TRUE))

Dane <- inner_join(Dane_Toyta2007, Dane_Toyta2008, by="Model") %>% 
  mutate(r�nica = �rednia.cena.y-�rednia.cena.x) %>% 
  select(Model, r�nica) %>% 
  arrange(r�nica) %>% 
  head(1)

## Odp: Hiace

## 6) W jakiej marce klimatyzacja jest najczesciej obecna?

auta2012  %>%
  select(Marka, Wyposazenie.dodatkowe) %>% 
  filter("klimatyzacja" %in% Wyposazenie.dodatkowe) %>%
  select(Marka) %>% 
  group_by(Marka) %>% 
  summarise(cz�sto��=n()) %>% 
  arrange(-cz�sto��) %>% 
  head(1)
  
## Odp: Volkswagen

## 7) Gdy ograniczyc sie tylko do aut z silnikiem ponad 100 KM, kt�ra Marka 
## wystepuje najczesciej w zbiorze danych auta2012?

auta2012 %>% 
  select(Marka, KM) %>% 
  filter(KM > 100) %>% 
  group_by(Marka) %>% 
  summarize(cz�sto��=n()) %>% 
  arrange(-cz�sto��) %>% 
  head(1)

## Odp:  Volkswagen

## 8) Gdy ograniczyc sie tylko do aut o przebiegu ponizej 50 000 km o silniku 
## diesla, kt�ra Marka wystepuje najczesciej w zbiorze danych auta2012?

auta2012 %>% 
  select(Marka, Przebieg.w.km, Rodzaj.paliwa) %>% 
  filter(Rodzaj.paliwa =="olej napedowy (diesel)", Przebieg.w.km < 50000) %>% 
  group_by(Marka) %>% 
  summarize(cz�sto��=n()) %>% 
  arrange(-cz�sto��) %>% 
  head(1)

## Odp:  BMW

## 9) Sposr�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest 
## srednio najdrozszy?

auta2012  %>% 
  select(Marka, Model, Rok.produkcji, Cena.w.PLN) %>% 
  filter(Rok.produkcji == 2007, Marka=="Toyota") %>% 
  select(-Marka, -Rok.produkcji) %>% 
  group_by(Model) %>% 
  summarise(�rednia.cena = mean(Cena.w.PLN, na.rm = TRUE)) %>% 
  arrange(-�rednia.cena) %>%
  head(1)
 
## Odp: Land Cruiser


## 10) Sposr�d aut marki Toyota, kt�ry model ma najwieksza r�znice cen 
## gdy por�wnac silniki benzynowe a diesel?

diesel <- auta2012 %>% 
  select(Marka, Rodzaj.paliwa, Model, Cena.w.PLN) %>% 
  filter(Marka=="Toyota", Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
  select(-Marka, -Rodzaj.paliwa) %>% 
  group_by(Model) %>% 
  summarise(�rednia.cena = mean(Cena.w.PLN, na.rm=TRUE))

benzyna <- auta2012 %>% 
  select(Marka, Rodzaj.paliwa, Model, Cena.w.PLN) %>% 
  filter(Marka=="Toyota", Rodzaj.paliwa == "benzyna") %>% 
  select(-Marka, -Rodzaj.paliwa) %>% 
  group_by(Model) %>% 
  summarise(�rednia.cena = mean(Cena.w.PLN, na.rm=TRUE))

dane <- inner_join(diesel, benzyna, by="Model") %>% 
  mutate(r�nica=abs(�rednia.cena.x-�rednia.cena.y)) %>% 
  select(Model, r�nica) %>% 
  arrange(-r�nica) %>% 
  head(1)

## Odp: Camry

