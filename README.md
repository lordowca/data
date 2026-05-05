# Projekty z zakresu analizy danych.

## 1. Data_jobs - Analiza ogłoszeń o pracę

Projekt został wykonany w czasie pracy nad tutorialem [Python for Data Analytics - Full Course for Beginners](https://youtu.be/wUSDVGivd-8?si=ySX9munPyzSP4vSX)

Wykorzystane technologie:

- Python z jupyter notebook,
- Pandas,
- Matplotlib oraz seaborn.

Przeprowadzona analiza na zbiorze ogłoszeń z 2023 miała odpowiedzieć na następujące pytania:

1. Jakie są najbardziej poszukiwane umiejętności dla trzech najpopularniejszych stanowisk?
2. Jakie są trendy najpopularniejszych umiejętności dla analityka danych w 2023 roku?
3. Jakie są zarobki dla top 6 najczęściej występujących stanowisk?
4. Jaki wpływ mają umiejętności na zarobki analityka danych?
5. Jakie są najbardziej optymalne umiejętności dla analityka danych?

[Dostęp do projektu data jobs](/data_jobs/README.md)

## 2. Toy store - data warehouse i analiza zamówień.

### 1. Opis projektu

Celem tego projektu było utrwalenie wiedzy z zakresu SQL, tworzenia DW zgodnie z zasadami opisanymi przez Baraa Khatib Salkin, oraz na podstawie utworzonego DW przeprowadzenie analizy pod kontem sprzedaży i ruchu na stronie sklepu.

Projekt składa się z dwóch części:

### A. Data Warehouse

Przygotowanie dokumentacji opisującej zasady jakimi należy kierować się przy tworzeniu DW, powiązań między importowanymi danymi oraz transformacje jakim poddano dane. Stworzona dokumentacja ma na celu ułatwienie utrzymanie i rozwijanie DW.

Zgodnie z Medalion Architecture zostały stworzone trzy warstwy w DW:

1. Bronze layer - import surowych danych (bez żadnych modyfikacji),
2. Silver layer - transformacja i standaryzacja danych,
3. Gold layer - przygotowanie danych w postaci widoków pod analizę.

### B. Część analityczna

Przy wykorzystaniu widoków z gold layer odpowiedzenie na pytania takiej jak:

1. Jaka jest konwersja sesji na sprzedaż?
2. Jaki jest trend sesji oraz zamówień?
3. Jaki był wpływ kampanii marketingowych na sprzedaż?
4. Jaki jest przychód rok do roku (YOY)?
5. Jak kształtują się przychody miesiąc do miesiąca (MOM)?
6. Jak zmieniał się średni przychód na zamówienie (RPO)?
7. Jaka jest różnica w przychodach między pierwszym kwartałem 2014, a 2015 roku?
8. Jaki produkt najlepiej się sprzedaje?

### 2. Technologia

Do realizacji projektu zostały wykorzystanie następujące oprogramowanie:

- Microsoft SQL Server 2025 uruchomiony lokalnie,
- VSCode wraz z rozszerzeniem:
    - SQL Server (mssql) - do komunikacji z serwerem SQL,
- draw.io do tworzenia grafik schematów,
- github do kontrolowania i przechowywania zmian w projekcie,
- MS Excel do wykonania wykresów.

### 3. Wiedza i umiejętności:

- Tworzenie lokalnego serwera SQL i konfiguracja VSCode do pracy z nim;
- wiedza związana z SQL min.:
    - pisanie zapytań,
    - tworzenie tabel w oparciu o Data Definition Language (DDL),
    - tworzenie procedur składowanych,
    - tworzenie widoków,
    - import danych z plików CSV,
    - łączenie tabel (JOIN),
    - czyszczenie danych (zmiana formatów, użycie CASE statement),
    - funkcje agregujące dane oraz metoda GROUP BY oraz VALUE functions,
    - wykorzystanie Common Table Expressions do tworzenia złożonych zapytań
- podstawowa wiedza na temat Data Warehouse,
- tworzenie schematów do dokumentacji,
- eksploracja danych i odpowiedź na pytania za pomocą wyników zapytań SQL.

[Dostęp do projektu toys store](/toy_store/README.md)
