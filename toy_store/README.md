# SQL From Zero to Hero

### Wstęp

Toy Store Data Warehouse jest odtworzeniem finalnego projektu z tutorialu [SQL Full Course for Beginners (30 Hours) – From Zero to Hero](https://youtu.be/SSKVgrwhzus?si=qlaMhBnlbYLVONpp) przy wykorzystaniu innych danych.
<br><br>
Celem tego ćwiczenia było utrwalenie wiedzy z zakresu SQL, tworzenia DW zgodnie z zasadami opisanymi przez Baraa Khatib Salkin, oraz na podstawie utworzonego DW przeprowadzenie analizy pod kontem sprzedaży i ruchu na stronie sklepu.

Dane do utworzenia Toy Store Data Warehouse zostały pobrane ze strony [Mavenan alytics](https://mavenanalytics.io/data-playground/toy-store-e-commerce-database).

## Tworzenia Toy Store Data Warehouse

### 1. Założenia projektu

Przed przystąpienie do prac w pierwszej kolejności został opisany cel projektu, dostępne źródła danych oraz wybrana metoda przechowywania i oddziaływania na dane. Również została określona konwencja nazewnictwa dla całego projektu.

- Cel oraz specyfikację projektu znajduje się w pliku [project_requirement](/toy_store/requirements/project_requirements.md);
- Przyjęta konwencja nazewnictwa znajduje się w pliku [project_naming_conv](/toy_store/requirements/project_naming_conv.md).

### 2. Inicjacja bazy danych i stworzenie schematów

Skrypt [init_database.sql](/toy_store/init_db/init_database.sql) sprawdza czy istniej już baza danych "ToyStoreDW", jeżeli tak to ją usuwa i tworzy na nowo. Następnie są tworzone trzy schematy zgodnie z przyjętą architekturą data warehouse.

### 3. Bronze layer

#### a. Utworzono tabele

- crm_order_item_refunds
- crm_order_items
- crm_orders
- crm_products
- web_website_pageviews
- web_website_sessions

Skrypt do stworzenia tabel dla bronze layer znajduje sie w pliku [ddl_bronze.sql](/toy_store/bronze/ddl_bronze.sql)

#### b. Ładowanie danych

Skrypt procedury składowanej posiada prostą formę logowania czynności poprzez wykorzystania funkcji PRINT. Zwraca informacje o:

- informacje o rozpoczęciu procesu,
- informacje związane z ładowaniem poszczególnych tabel (usunięcie zawartości tabeli, ładowanie danych, ilość wierszy, i czas ładowania danych),
- na koniec jest podany całkowity czas wykonania procedury.

Skrypt z procedury składowanej dla bronze layer znajduje sie w pliku [proc_load_bronze.sql](/toy_store/bronze/proc_load_bronze.sql)

### 3. Silver layer

#### a. Powiązania między tabelami

![tables_connections](/toy_store/silver/images/tables_connections.drawio.png)
Table posiadają kolumny z primary keys umożliwiające podłączenie tabel ze sobą i nie jest wymagana ingerencja w dane w tym zakresie.

#### b. Utworzono tabele

- crm_order_item_refunds
- crm_order_items
- crm_orders
- crm_products
- web_website_pageviews
- web_website_sessions

Skrypt do stworzenia tabel dla silver layer znajduje sie w pliku [ddl_silver.sql](/toy_store/silver/ddl_silver.sql)

#### c. Ładowanie danych

Do wszystkich tabel została dodana kolumna techniczna dwh_create_date.
W tabeli web_website_sessions zostały przeprowadzone następujące modyfikacje:

- W kolumnie is_repeat_session wartość 0 została zmieniona na False, a wartość 1 została zmieniona na True.
- W tabeli web_website_sessions wartości null zostały zamienione w kolumnach: <br>
  **- utm_source** na "no sorce",<br>
  **- utm_campaign** na "no campaign",<br>
  **- utm_content** na "without advertising campaigns",<br>
  **- http_referer** na "directly".<br>
- w kolumnie utm_content oznaczenia kampanii zostały zmienione na opisy:<br>
  **- social_ad_1:** social media advertising campaign 1,<br>
  **- social_ad_2:** social media advertising campaign 2,<br>
  **- b_ad_1:** search media advertising campaign 1,<br>
  **- b_ad_2:** search media advertising campaign 2,<br>
  **- g_ad_1:** gsearch media advertising campaign 1,<br>
  **- g_ad_2:** gsearch media advertising campaign 2.<br>
- W kolumnie http_referer wartość null zastąpiono słowem directly, wskazującym na bezpośrednie wejście na stronę sklepu.

Skrypt procedury składowanej posiada prostą formę logowania czynności poprzez wykorzystania funkcji PRINT. Zwraca informacje o:

- informacje o rozpoczęciu procesu,
- informacje związane z ładowaniem poszczególnych tabel (usunięcie zawartości tabeli, ładowanie danych, ilość wierszy, i czas ładowania danych),
- na koniec jest podany całkowity czas wykonania procedury.

Skrypt z procedury składowanej dla silver layer znajduje sie w pliku [proc_load_silver.sql](/toy_store/silver/proc_load_silver.sql)

#### d. Sprawdzenie danych

Po wykonaniu procedury składowej zostało przeprowadzone sprawdzenie kolumn z kluczami głównymi (primary key) czy nie zawierają duplikatów lub wartości null dla tabel:

- silver.crm_orders
- silver.crm_order_items
- silver.crm_order_item_refunds
- silver.web_website_pageviews
- silver.web_website_sessions

oraz poprawność podmiany danych w:

- kolumnie z tabeli silver.crm_order_items:
    - is_primary_item
- kolumn z tabeli silver.web_website_sessions:
    - is_repeat_session,
    - utm_source,
    - utm_campaign,
    - utm_content,
    - http_referer.

### 4. Gold layer

#### a. Powiązania między tabelami

Na poniższym schemacie są zaznaczone jakie tabele zostały wykorzystane do stworzenia widoków w gold layer.
![tables_to_views](/toy_store/gold/images/tables_to_view.drawio.png)

#### b. Utworzono widoki

- **fact_website_pageview** - łączy informacje o odwiedzanych stronach z informacjami o sesjach użytkowników;
- **dim_session** - wszystkie sesje użytkowników jakie miały miejsce w okresie pobranych danych sprzedażowych;
- **fact_orders** - zawiera informacje o sprzedaży uzupełnione o informacje z sesji uzytkownika dokującego zamówienie;
- **fact_order_items** - przypisanie produktów do zamówień;
- **fact_order_item_refunds** - zwrócone przedmioty przez klientów;
- **dim_products** - informacje o produkcie;
- **agg_orders** - widok podsumowujący: ilość zamówień, ilość sprzedanych przedmiotów, przychód, koszt towarów, ilość zwróconych przedmiotów.

Skrypt tworzący widoki dla gold layer znajduje sie w pliku [ddl_gold.sql](/toy_store/gold/ddl_gold.sql)

#### d. Grain & Keys

Pojedynczy wiersz w tabeli fact_order_item_refunds zawiera informację na temat zwróconego przedmiotu. Ta table pozwala agregować takie dane jak ilość zwróconych przedmiotów, całkowity koszt zwrotów, określić jaki przedmiot był najczęściej zwracany. Do każdego zwróconego przedmiotu jest zapisane id zamówienia (order_id), co daje możliwość powiązania zwrotu z wcześniejszym zamówieniem.

Tabela fact_orders w pojedynczym wierszu przechowuje informacje o każdym złożonym zamówieniu przez klienta podczas sesji na stronie internetowej. Ta tabela gromadzi takie wskaźniki jak całkowity przychód, koszty sprzedanych produktów oraz umożliwia powiązanie ich z odpowiednią sesją i kontekstem marketingowym.

Tabela fact_order_items w pojedynczym wierszu odpowiada pojedynczemu produktowi w ramach złożonego zamówienia. Umożliwia to szczegółową analizę sprzedaży na poziomie produktów, składu koszyka przy zachowaniu relacji "jeden do wielu" z tabelą fact_orders.

Tabela fact_website_pageview w pojedynczym rekordzie przechowuje informacje na temat odwiedzonej strony przez użytkownika i łączy to z sesją. Pozwala to na przeanalizowanie ruchu na stronie oraz połączenie to z kontekstem marketingowym. Tabela fact_website_pageview jest w relacji "wiele do jednego" z tabelą dim_session.

W ramach tego projektu do identyfikacji rekordów w różnych warstwach wykorzystywane są naturalne klucze biznesowe pochodzące z systemu CRM (np. order_id, product_id). Surrogate keys zostały celowo pominięte w celu uproszczenia modelu danych w ramach projektu edukacyjnego; jednakże konwencja nazewnictwa i struktura tabel umożliwiają łatwe rozszerzenie o Surrogate keys i powoli zmieniające się wymiary w przyszłych wersjach projektu.

### 5. Przepływ danych między warstwami

![data_flow](/toy_store/gold/images/data_flow.drawio.png)

## Analiza danych

Dane w Data Warehouse obejmują okres **od 2012-03-19 do 2015-03-19**

### 1. Jaka jest konwersja sesji na sprzedaż?

W całym okresie konwersja wyniosła **6.8%**. Natomiast jak przyjrzymy się konwersji dla poszczególnych lat to można zauważyć systematyczny wzrost tego parametru.

|  #  | year | conversion_rate_procent |
| :-: | :--: | :---------------------: |
|  1  | 2012 |           4,1           |
|  2  | 2013 |           6,6           |
|  3  | 2014 |           7,2           |
|  4  | 2015 |           8,4           |

Plik źródłowy [1_sessions.sql](/toy_store/analysis/1_sessions.sql)

### 2. Jaki jest trend sesji oraz zamówień?

|  #  | year | orders | sessions |
| :-: | :--: | :----: | -------- |
|  1  | 2012 |  2586  | 62470    |
|  2  | 2013 |  7447  | 112781   |
|  3  | 2014 | 16860  | 233422   |
|  4  | 2015 |  5420  | 64198    |

Ilość zamówień i sesji na stronie rośnie. Rok 2014 pod tym względem odnotował najwyższe wartości. Dla roku 2015 mamy dane wyłączne do dnia 19 marca, które wskazują na bardzo dobre wyniki sprzedażowe w pierwszym kwartale.

Plik źródłowy [2_session_orders.sql](/toy_store/analysis/2_session_orders.sql)

### 3. Jaki był wpływ kampanii marketingowych na sprzedaż?

|  #  |         campaign_description         | campaign_parameter | campaign_start | campaign_end | session_from_channel | orders_from_campaign | conversion_rate_procent |
| :-: | :----------------------------------: | :----------------: | :------------: | :----------: | :------------------: | :------------------: | :---------------------: |
|  1  | gsearch media advertising campaign 1 |     non brand      |   2012-03-19   |  2015-03-19  |        282706        |        18822         |          6,66           |
|  2  |    without advertising campaigns     |    no campaign     |   2012-03-25   |  2015-03-19  |        83328         |         6118         |          7,34           |
|  3  | bsearch media advertising campaign 1 |     non brand      |   2012-08-19   |  2015-03-19  |        54909         |         3818         |          6,95           |
|  4  | gsearch media advertising campaign 2 |       brand        |   2012-03-25   |  2015-03-19  |        33329         |         2511         |          7,53           |
|  5  | bsearch media advertising campaign 2 |       brand        |   2012-03-27   |  2015-03-19  |         7914         |         701          |          8,86           |
|  6  | social media advertising campaign 2  |  desktop_targeted  |   2014-08-17   |  2014-12-27  |         5590         |         288          |          5,15           |
|  7  | social media advertising campaign 1  |       pilot        |   2014-01-12   |  2014-03-15  |         5095         |          55          |          1,08           |

### Wnioski

- Kampania 1 typu "non brand" dla **gsearch** ma największą ilość zrealizowanych zamówień, ale zarazem najniższą konwersję z kampanii długoterminowych.
- Kampania 1 typu "non brand" dla **bsearch** zajmuje trzecią pozycję w powyższym zestawienia, ze znacząco mniejszą ilością zrealizowanych zamówień.
- Należy zwrócić uwagę na to że wejścia bezpośrednie oraz z wyników wyszukiwań (bez kampanii) osiągnęły drugi wynik w kategorii ilości zamówień oraz odbytych sesji.
- Kampanie marketingowe dla gshearch przyniosły najwyższe wyniki sprzedażowe.

Plik źródłowy [3_marketing_channel.sql](/toy_store/analysis/3_marketing_channel.sql)

### 4 Przychody

**Z tabeli fact_orders zostały usunięte zwrócone zamówienia.**

#### 4.1 Jaki jest przychód rok do roku (YOY)?

|  #  | year | total_revenue | yoy_growth_procent |
| :-: | :--: | :-----------: | :----------------: |
|  1  | 2012 |   120375.92   |         0          |
|  2  | 2013 |   375655.33   |        212         |
|  3  | 2014 |  1008698.42   |        169         |
|  4  | 2015 |   324500.94   |        -68         |

- W 2012 mamy dane za ostatnie dziewięć miesięcy działalności sklepu, związku z tym wzrost w roku 2013 nie jest wskaźnikiem dokładanym.
- Obliczony wzrost dla roku 2014 wskazuje na bardzo duży wzrost sprzedaży wynoszący 169%.
- Po pierwszych trzech miesiącach 2015 roku uzyskano 32% przychodu z roku 2014.

Plik źródłowy [4.1_yoy_revenues.sql](/toy_store/analysis/4.1_yoy_revenues.sql)

#### 4.2 Jak kształtują się przychody miesiąc do miesiąca (MOM)?

- Rok 2012 do listopada charakteryzował się stałym wzrostem przychodu miesiąc do miesiąca, natomiast grudzień zanotował 17% spadek w stosunku do listopada.
- Lata 2013-2014 już nie mają takiej dynamiki wzrostu przychodów jak rok 2012 i pojawiają się miesiące z gorszą sprzedażą.
- Rok 2015 rozpoczyna sie lekkim spadkiem przychodu z miesiąca na miesiąc.

Plik źródłowy [4.2_mom_revenues.sql](/toy_store/analysis/4.2_mom_revenues.sql)

#### 4.3 Jak zmieniał się średni przychód na zamówienie (RPO)?

|  #  | year |  rpo  | rpo_growth |
| :-: | :--: | :---: | :--------: |
|  1  | 2012 | 49,99 |     0      |
|  2  | 2013 | 52,82 |    5,66    |
|  3  | 2014 | 63,52 |   20,27    |
|  4  | 2015 | 62,51 |   -1,59    |

- Rok 2014 miał o 20% wyższy średni przychód na zamówienie niż rok 2013. Z tego wynika, że nie tylko nastąpił wzrost ilość zamówień, ale również wielkość koszyka uległa zmianie.
- Rozpoczęty rok 2015 w pierwszym kwartale ma nieznacznie mniejszy średni przychód na zamówienie niż rok poprzedni.

Plik źródłowy [4.3_rpo.sql](/toy_store/analysis/4.3_rpo.sql)

#### 4.4 Porównanie pierwszego kwartału 2014 i 2015 roku

|  #  | year | Q1_orders_value | difference_quarter |
| :-: | :--: | :-------------: | :----------------: |
|  1  | 2014 |    181813.00    |         0          |
|  2  | 2015 |    324500.94    |     142687.94      |

Plik źródłowy [4.4_difference_quarter.sql](/toy_store/analysis/4.4_difference_quarter.sql)

### Wnioski

Długoterminowe kampanie marketingowe tupu "non brand" zapewniły zwiększenie ilość odwiedzin i zamówień. Widać to w szczególności w roku 2014, gdzie mogliśmy zaobserwować najwyższy przychód oraz najwyższy średni przychód na zamówienie. Patrząc na danę z początku roku 2015 można stwierdzić, że trend sprzedaży jest wzrostowy.

### 5 Jaki produkt najlepiej się sprzedaje?

|  #  |        product_name        | total_seal |
| :-: | :------------------------: | :--------: |
|  1  |   The Original Mr. Fuzzy   |   24226    |
|  2  |   The Forever Love Bear    |    5796    |
|  3  |  The Birthday Sugar Panda  |    4985    |
|  4  | The Hudson River Mini bear |    5018    |

## Podsumowanie

### 1. Wiedza i umiejetnosci

Wiedza i umiejetnosci jakie zdobyłem w czasie pracy nad tutorialem [SQL Full Course for Beginners (30 Hours) – From Zero to Hero](https://youtu.be/SSKVgrwhzus?si=qlaMhBnlbYLVONpp) oraz projektem Toy Store Data Warehouse min.:

- Tworzenie lokalnego serwera SQL i konfiguracja VSCode do pracy z nim;
- wiedza związana z SQL:
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

### 2. Rozwinięcie projektu

- wprowadzić przechowywanie danych historycznych bez każdorazowego kasowania danych,
- zastosowanie Surrogate keys w gold layer,
- dodanie systemu logowania operacji ETL (zapis postępu i błędów w bazie danych),
- zastosowanie tabel zamiast widoków dla danych ogólnie zagregowanych jak np. całkowity przychód, ilość zamówień, KPI itp.

## Informacje techniczne do projektu

### 1. Jak uruchomić projekt

Do uruchomienia projektu należy mieć dostęp do Microsoft SQL Server na którym zostanie utworzona baza danych i zaimportowane dane. Do wykonania kolejnych kroków wykorzystaj np SQL Server Management Studio (SSMS):

1. Połącz się z serwerem SQL.
2. Utwórz baza danych za pomocą skryptu [init_database.sql](/toy_store/init_db/init_database.sql).<br>
   **UWAGA!** wykonanie tego pliku usunie bazę danych ToyStoreDW jeżeli taka istnieje.
3. Utwórz table dla bronze layer za pomocą skryptu [ddl_bronze.sql](/toy_store/bronze/ddl_bronze.sql).
4. Utwórz procedurę składowaną dla bronze layer [proc_load_bronze.sql](/toy_store/bronze/proc_load_bronze.sql)

5. Uruchom procedurę składowaną dla bronze layer na serwerze za pomocą komendy:

    ```SQL
    EXEC bronze.load_bronze
    @BasePath = 'path_to_project_folder';
    ```

    Przykład ścieżki do folderu jaki nalezy umieścić w zmiennej @BasePath:<br> **'C:\Users\Jan Kowalski\Documents\Projekty'** <br>
    Na końcu ścieżki nie umieszczaj backslasha.

6. Utwórz table dla silver layer za pomocą skryptu [ddl_silver.sql](/toy_store/silver/ddl_silver.sql)
7. Utwórz procedurę składowania dla silver layer [proc_load_silver.sql](/toy_store/silver/proc_load_silver.sql)
8. Uruchom procedurę składowaną na serwerze za pomocą komendy:

    ```SQL
    EXEC silver.load_silver
    ```

9. Utwórz widoki dla golden layer za pomocą skryptu [ddl_gold.sql](/toy_store/gold/ddl_gold.sql)

### 2. Struktura projektu

```
toy_store
|
├── analysis/                                 # Skrypty SQL zwiazane z analizą danych zawartych w DW.
|   ├── 1_sessions.sql                        # Skrypt SQL wyliczający konwersję sesji na sprzedaż.
|   ├── 2_session_orders.sql                  # Skrypt SQL wyliczający ilość zamówień i sesji w podziale na lata.
|   ├── 3_marketing_channel.sql               # Skrypt SQL wyliczający ilość sesji przypadających na kampanie.
|   ├── 4.1_yoy_revenues.sql                  # Skrypt SQL wyliczający przychód rok do roku (YOY).
|   ├── 4.2_mom_revenues.sql                  # Skrypt SQL wyliczający przychód miesiąc do miesiąca (MOM).
|   ├── 4.3_rpo.sql                           # Skrypt SQL wyliczający średni przychód na zamówienie (ROP).
|   ├── 4.4_difference_quarter.sql            # Skrypt SQL wyliczający różnicę w przychodach miedzy pierwszymi  |kwartałami roku 2014 i 2015
|   ├── 5_top_products.sql                    # Skrypt SQL zwracający zestawienie ilość sprzedanych sztuk produktów.
├── bronze/                                   # Skrypt SQL dotyczące bronze layer.
|   ├── ddl_bronze.sql                        # Skrypt SQL tworzący tabele.
|   ├── proc_load_bronze.sql                  # Skrypt SQL procedury składowanej (pobieranie i importowanie surowych danych).
├── data_sets/                                # Dane użyte w projekcie.
|   ├── crm/                                  # Cztery pliki CSV z systemu CRM.
|   ├── web/                                  # Dwa pliki CSV z systemu monitorowania ruchu na stronie.
├── gold/                                     # Skrypt SQL i rysunki dotyczące gold layer.
|   ├── images/
|   |   ├── data_flow.drawio.png              # Schemat przepływu danych między warstwami DW.
|   |   ├── tables_to_view.drawio.png         # Schemat powiązań miedzy tabelami wraz zaznaczeniem wykorzystania ich do stworzenia widoków.
|   ├── ddl_gold.sql                          # Skrypt SQL tworzący widoki.
├── int_db/                                   # Folder zawiera skrypt SQL inicjujący bazę danych oraz tworzący schematy.
├── requirements/                             # Zawiera pliki z opisem założeń projektu i konwencją nazewnictwa.
├── silver/                                   # Skrypt SQL i rysunki dotyczące silver layer.
|   ├── images/
|   |   ├── tables_connections.drawio.png     # Schemat połączeń między tabelami.
|   ├── ddl_silver.sql                        # Skrypt SQL tworzący tabele.
|   ├── proc_load_silver.sql                  # Skrypt SQL procedury składowanej czyszczenie i transformacja danych.
|   ├── test.sql                              # Skrypt SQL z testami.
├── README                                    # Przegląd projektu i instrukcje.
```

### 3. Oprogramowanie

Do realizacji projektu zostały wykorzystanie następujące oprogramowanie:

- Microsoft SQL Server 2025 uruchomiony lokalnie,
- VSCode wraz z rozszerzeniem:
    - SQL Server (mssql) - do komunikacji z serwerem SQL,
- draw.io do tworzenia grafik schematów,
- github do kontrolowania i przechowywania zmian w projekcie.

---

[Inne projekty](/README.md)
