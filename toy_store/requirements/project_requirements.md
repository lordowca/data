# Założenia projektu

### Cel projektu

Zbudowanie nowoczesnego Data warehouse, aby uzyskać dane zbiorcze dla sklepu online z zabawkami w celach analizy i raportowania.

### Specyfikacja

- **Źródło danych:** pliki CSV z CRM oraz systemu monitorujacego ruch na stronie,
- **Jakość danych:** czyszczenie i przygotowanie danych przed dalszą analizą,
- **Dokumentacja:** przygotowanie dokumentacji dla modelowania danych oraz dla wsparcia analityków.
- **Przechowywanie danych:** projekt nie zakłada przechowywania historycznych danych, tylko importowanie nowych danych po każdorazowym eksporcie z CRM i systemu do monitorowania ruchu.

### Wybrana architektura

Dla Data Warehouse zostanie zastosowana Medalion Architecture.

![Założenia dla data warehouse](/toy_store/requirements/images/layers_schema.png)

[Powrót do głównego README](/toy_store/README.md)
