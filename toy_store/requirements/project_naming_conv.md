# Konwencja nadawania nazw w projekcie

### 1. Zasady ogólne

- konwencja nazw: należy używać snake_case
- język: Angielski

### 2. Konwencja nazywania tabel

#### **Bronze layer**

- Wszystkie tabele muszą zaczynać się od nazwy źródła z zachowanymi nazwami pochodzącymi od importowanych tabel;
  np. źródło_nazwa_pliku.

#### **Silver layer**

- Wszystkie tabele muszą zaczynać się od nazwy źródła z zachowanymi nazwami pochodzącymi od importowanych tabel;
  np. źródło_nazwa_pliku.

#### **Gold layer**

- Wszystkie nazwy widoków muszą być sensowne i zgodne z profilem działalności firmy a ich nazwy powinny zaczynać się od odpowiednich prefiksów np. prefix_nazwa_widoku.

    | prefix |    znaczenie     |
    | :----: | :--------------: |
    | dim\_  | dimension tabel  |
    | fact\_ |    fact tabel    |
    | agg\_  | aggregated tabel |

### 3. Konwencja nazywania kolumn

#### **Surrogate keys**

- Wszystkie Surrogate keys w tabelach muszą mieć konstrukcję suffix_key;
- Suffix odnosi sie do nazwy tabeli, w której został utworzony;
- Końcówka key jest wskaźnikiem, że kolumna zawiera surrogate keys.

#### **Technical columns**

- Wszystkie techniczne kolumny muszą zaczynać się od dwh\_, a następnie posiadać nazwę, która jednoznacznie określi ich zastosowanie.

#### **Stored procedure**

- Wszystkie procedury muszą składać się z przedrostka load\_, a po nim nazwa warstwy, której dotyczą.

[Powrót do głównego README](/toy_store/README.md)
