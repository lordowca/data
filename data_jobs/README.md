# Analiza ofert pracy z 2023 roku dla stanowisk związanych z danmi.

## 1. Jakie są najbardziej poszukiwane umiejętności dla trzech najpopularniejszych stanowisk?

Najwięcej ogłoszeń opublikowano dla następujących stanowisk:

- Data Analyst,
- Data Engineer,
- Data Scientist.

Zestaw danych został zawężony do wierszy spełniających następujące warunku:

- **rola:** trzy najczęściej występujące stanowiska,
- **kraj:** United States

Dla każdego stanowiska wybrano pięć najczęściej występujących umiejętność.

Więcej szczegółów można zobaczyć w notebook'u: [2_skill_demand.ipynb](2_skill_demand.ipynb)

### Wynik

![Wizualizacja kluczowych umiejętności](/data_jobs/images/skill_demand.png)

### Wnioski

- dla Data Scientist i Data Engineer kluczową umiejętnością jest znajomość Pythona oraz SQL.
- Data Analyst powinien znac dobrze SQL, tableau oraz Excela.

## 2. Jakie są trendy najpopularniejszych umiejętności dla analityka danych w 2023 roku?

Zestaw danych został zawężony do wierszy spełniających następujące warunku:

- **rola:** Data Analyst
- **kraj:** United States

Następnie dane zostały zgromadzone w postaci tabeli przestawnej, aby określić ilość ogłoszeń zawierających daną umiejętność w poszczególnym miesiącu. Dane zostały przeliczone na procent ogłoszeń zawierających daną umiejętność. Następnie wyniki zostały ograniczone do top 5 umiejętności.

Więcej szczegółów można zobaczyć w notebook'u:
[3_skill_trend.ipynb](\3_skill_trend.ipynb)

### Wynik

![Wizualizacja trendów dla kluczowych umiejętności](/data_jobs/images/skills_trend_DA.png)

### Wnioski

- W przeciągu roku widać nieznaczny spadek ogłoszeń zawierających SQL, ale nadal jest to najczęściej występująca umiejętność.
- W ogłoszeniach tableau i python pojawiają w zbliżonej ilość. Pod koniec roku ilość ogłoszeń zawierających pythona znacznie wzrosła.
- Trendy dla top 5 umiejętności dla Data Analyst wykazują niewielkie zmiany.

## 3. Jakie są zarobki dla top 6 najczęściej występujących stanowisk?

Zestaw danych został zawężony do wierszy spełniających następujące warunku:

- **kraj:** United States.

W 2023 roku najwięcej ogłoszeń pojawiło się dla tych sześciu stanowisk:

- Data Analyst,
- Data Engineer,
- Data Scientist,
- Business Analyst,
- Software Engineer,
- Senior Data Engineer

Na podstawie tej listy zostały wybrane dane do sporządzenia zestawienia mediany zarobków.

Więcej szczegółów można zobaczyć w notebook'u:
[4_salary_analysis.ipynb](4_salary_analysis.ipynb)

### Wynik

![Wizualizacja mediany zarobków dla top 6 stanowisk](/data_jons/images/top_6_median.png)

### Wnioski

- Zarobki analityka danych i analityka biznesowego są do siebie zbliżone.
- Na wykresie możemy zaobserwować, żę wszystkie stanowiska mają wartości odstające po prawej stronie. Może to wynikać z dodatkowych wymagań zawartych w poszczególnych ogłoszeniach.

## 4. Jaki wpływ mają umiejętności na zarobki analityka danych?

Zestaw danych został zawężony do wierszy spełniających następujące warunku:

- **rola:** Data Analyst
- **kraj:** United States

Z tych danych zostały powstały dwa zestawienia:

- Top 5 umiejętności z najwyższą medianą.
- Top 5 najczęściej występujących umiejętności w ogłoszeniach w odniesieniu do mediany.

Więcej szczegółów można zobaczyć w notebook'u:
[4_salary_analysis.ipynb](4_salary_analysis.ipynb)

### Wynik

![Wizualizacja mediany zarobków dla top 5 umiejętności](/data_jobs/images/top_5_skills_median.png)

### Wnioski

- Umiejętności niszowe pojawiają się najlepiej opłacanych ogłoszeniach.
- Umiejętności najczęściej występujące są związane z językami programowania i wizualizacją danych.

## 5. Jakie są najbardziej optymalne umiejętności dla analityka danych

### Wyniki

![Optymalne umiejętności dla analityka danych](images\optimal_skills.png)

### Wnioski

- Oferty z najwyższą medianą zarobków zawierają języki programowania takie jak python oraz sql. Jednocześnie są to najczęściej występujące umiejętności w ogłoszeniach.
- Excel jest podstawowym narzędziem dla analityka danych, występuje w ponad 40% ogłoszeń.
- W 2023 roku tableau jako narzędzie do wizualizacji danych występowało znacznie częściej niz power bi.
