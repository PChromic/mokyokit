Notatki do zadania:

Zadanie 1:

Ca�o�� problemu roz�o�y�em na nast�puj�ce cz�ci:
* Deserializacja pliku statuses.json -> zapis do obiektu Status. Obiekt Status jest odwzorowaniem struktury pliku JSON.
* Filtracja i sortowanie pobranych z obiektu Status listy obiekt�w Contact, b�d�cych zapisem szczeg��w kontaktu pracownika z klientem
* Serializacja -> zapis do pliku statuses.csv

G��wnym za�o�eniem przyj�tym podczas tworzenia projektu by�o maksymalne wykorzystanie zweryfikowanych bibliotek zewn�trznych umo�liwiaj�cych sprawn� i zwi�z�� implementacj� odczytu i zapisu plik�w. 
Starano si� r�wnie� post�powa� wed�ug zestawu wytycznych SOLID. 
D��ono do tego by ka�da klasa by�a odpowiedzialna tylko i wy��cznie za jedn� funkcjonalno�� (przyk�ad: jsonMapper � jego jedyn� rol� jest mapowanie json do obiekt�w). 
Zapewniono otwarto�� na poszerzenie funkcjonalno�ci  dzi�ki interfejsom (przyk�ad:  Contact Service � gdyby w specyfikacji pojawi�a si� konieczno�� implementacji kolejnej funkcjonalno�ci dotycz�cej kontakt�w z klientem, 
wystarczy stworzy� stosown� deklaracj� i jej implementacj�.)

 
Notatki do zada� 2 i 3 znajduj� si� odpowiednio w plikach: zadanie2.sql i zadanie3.sql w pierwszych linijkach plik�w.
