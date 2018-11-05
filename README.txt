Notatki do zadania:

Zadanie 1:

Ca³oœæ problemu roz³o¿y³em na nastêpuj¹ce czêœci:
* Deserializacja pliku statuses.json -> zapis do obiektu Status. Obiekt Status jest odwzorowaniem struktury pliku JSON.
* Filtracja i sortowanie pobranych z obiektu Status listy obiektów Contact, bêd¹cych zapisem szczegó³ów kontaktu pracownika z klientem
* Serializacja -> zapis do pliku statuses.csv

G³ównym za³o¿eniem przyjêtym podczas tworzenia projektu by³o maksymalne wykorzystanie zweryfikowanych bibliotek zewnêtrznych umo¿liwiaj¹cych sprawn¹ i zwiêz³¹ implementacjê odczytu i zapisu plików. 
Starano siê równie¿ postêpowaæ wed³ug zestawu wytycznych SOLID. 
D¹¿ono do tego by ka¿da klasa by³a odpowiedzialna tylko i wy³¹cznie za jedn¹ funkcjonalnoœæ (przyk³ad: jsonMapper – jego jedyn¹ rol¹ jest mapowanie json do obiektów). 
Zapewniono otwartoœæ na poszerzenie funkcjonalnoœci  dziêki interfejsom (przyk³ad:  Contact Service – gdyby w specyfikacji pojawi³a siê koniecznoœæ implementacji kolejnej funkcjonalnoœci dotycz¹cej kontaktów z klientem, 
wystarczy stworzyæ stosown¹ deklaracjê i jej implementacjê.)

 
Notatki do zadañ 2 i 3 znajduj¹ siê odpowiednio w plikach: zadanie2.sql i zadanie3.sql w pierwszych linijkach plików.
