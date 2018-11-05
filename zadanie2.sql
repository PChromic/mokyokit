-- ----------------------------------------------------------------------
-- Przed rozpoczęciem zadania należało stworzyć bazę danych (tu: contacts).
-- Zadanie rozpoczynałem od importowania rekordów za pomocą Table Data Import Wizard.
-- Następnie skupiłem się na uzyskaniu rekordów ostatnich kontaktów z klientami.
-- Ostatnim krokiem było uzyskanie tylko tych danych, które występowały co najmniej 3 razy.
-- ----------------------------------------------------------------------
 SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SELECT 
	k.klient_id,c.stat AS statusy ,
    latest_call AS data_ostatniego_kontaktu
FROM
	contacts AS c
JOIN (
	SELECT klient_id,MAX(ts) AS latest_call
	FROM contacts
	GROUP BY klient_id
	HAVING COUNT(klient_id)>2) AS k
	 ON k.latest_call = c.ts;

