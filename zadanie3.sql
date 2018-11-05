-- ----------------------------------------------------------------------
-- Zadanie rozpoczynałem od importowania rekordów za pomocą Table Data Import Wizard.
-- Każdą z poniższych kwerend zaczynałem od analizy jakie informacje powinny być uzyskane oraz w jaki sposób przedstawione.
-- NAStepnie pisałem zapytania które zwracały wszystkie rekordy spełniające założenie biznesowe, których ilość pózniej sumowałem.
-- Testy pierwotnie pisane były na mojej tabeli zawierającej rekordy spełniające wszystkie wymagania, nAStępnie na tabeli statuses.csv. 
-- ----------------------------------------------------------------------



 SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
USE pchromic;

SELECT 
	*
FROM(
	-- sukcesy - liczba klientów, których ostatnim statusem jest “zainteresowany”
	SELECT
		COUNT(*) AS sukcesy
	FROM
		contacts AS c
		JOIN (
			SELECT 
				klient_id,MAX(ts) AS 
                latest_call
			FROM 
				contacts
			WHERE 
				stat = "interested"
			GROUP BY 
				klient_id
			) AS k
			 ON k.latest_call = c.ts
	) AS sukcesy,  
	-- utraty - liczba klientów, których ostatnim statusem jest “niezainteresowany”
	(
    SELECT 
		COUNT(*) AS utraty
	FROM
		contacts AS c
		JOIN (
			SELECT 
				klient_id,MAX(ts) AS 
				latest_call
			FROM 
				contacts
			WHERE 
				stat = "not_interested"
			GROUP BY 
				klient_id
			) AS k
			 ON k.latest_call = c.ts
	) AS utraty,
    (
	-- do_ponowienia - liczba klientów, których ostatni status to “poczta_głosowa” lub "nie_ma_w_domu"
	SELECT 
		COUNT(*) AS do_ponowienia
	FROM
		contacts AS c
		JOIN (
			SELECT 
				klient_id,
                MAX(ts) AS latest_call
			FROM 
				contacts
			WHERE 
				stat = "voice_mail" OR 
                stat = "not_at_home"
			GROUP BY 
				klient_id
			) AS k
			 ON k.latest_call = c.ts
    ) AS do_ponowienia,
    (
	-- zainteresowani_utraty - liczba klientów, których ostatnim statusem jest “niezainteresowany”, a poprzednio wystąpił status “zainteresowany”
	 
	SELECT
		COUNT(*) AS zainteresowani_utraty
	FROM
		(
		SELECT
			c1.klient_id AS klient1,
			c2.klient_id AS klient2,
			c1.stat  AS curr_stat,
			c2.stat AS prev_stat, 
			RANK() OVER(partition by c1.klient_id order by c1.ts DESC) AS a
		FROM
			contacts c1
			INNER JOIN
				contacts c2 ON c2.id = c1.id + 1
		) AS t
	WHERE
		t.curr_stat = 'not_interested' AND 
        t.prev_stat = 'interested' AND 
        t.klient1 = t.klient2 AND 
        a = 1		
    ) AS zainteresowani_utraty,
    (
	 -- niezainteresowani_sukcesy - liczba klientów, których ostatnim statusem jest “zainteresowany”, a poprzednio wystąpił status “niezainteresowany”
	SELECT
		COUNT(*) AS niezainteresowani_sukcesy
	FROM
		(
		SELECT
			c1.klient_id AS klient1,
			c2.klient_id AS klient2,
			c1.stat  AS curr_stat,
			c2.stat AS prev_stat, 
			RANK() OVER(partition by c1.klient_id order by c1.ts DESC) AS a
		FROM
			contacts c1
			INNER JOIN
				contacts c2 ON c2.id = c1.id + 1
		) AS t
	WHERE
		t.curr_stat = 'interested' AND 
        t.prev_stat = 'not_interested'AND 
        t.klient1 = t.klient2 AND 
        a = 1       
    ) AS niezainteresowani_sukcesy;

-- ----------------------- MIARY ----------------------- --
-- ----------------------------------------------------------------------
-- sukcesy - liczba klientów, których ostatnim statusem jest “zainteresowany”
SELECT 
   	count(k.klient_id) AS sukcesy,
    SUBSTRING(k.latest_call,1,10) AS data_osiagniecia_statusu
FROM
    contacts AS c
    JOIN (
		SELECT klient_id,MAX(ts) AS latest_call
        FROM contacts
        WHERE stat = "interested"
        GROUP BY klient_id
        ) AS k
         ON k.latest_call = c.ts AND k.klient_id = c.klient_id
GROUP BY 
	k.latest_call;
 
-- ----------------------------------------------------------------------
-- utraty - liczba klientów, których ostatnim statusem jest “niezainteresowany”
SELECT 
   	COUNT(*) AS utraty,
    SUBSTRING(k.latest_call,1,10) AS data_osiagniecia_statusu
FROM
    contacts AS c
    JOIN (
		SELECT klient_id,MAX(ts) AS latest_call
        FROM contacts
        WHERE stat = "not_interested"
        GROUP BY klient_id
        ) AS k
         ON k.latest_call = c.ts AND k.klient_id = c.klient_id
GROUP BY 
	k.latest_call;                  
 
-- ----------------------------------------------------------------------
-- do_ponowienia - liczba klientów, których ostatni status to “poczta_głosowa” lub "nie_ma_w_domu"
SELECT 
	COUNT(*) AS do_ponowienia,
    SUBSTRING(k.latest_call,1,10) AS data_osiagniecia_statusu
FROM
    contacts AS c
    JOIN (
		SELECT 
			klient_id,MAX(ts) AS latest_call
        FROM 
			contacts
        WHERE 
			stat = "voice_mail" OR stat = "not_at_home"
        GROUP BY 
			klient_id
        ) AS k
         ON k.latest_call = c.ts AND k.klient_id = c.klient_id
GROUP BY 
	k.latest_call;
         
 
-- ----------------------------------------------------------------------
-- zainteresowani_utraty - liczba klientów, których ostatnim statusem jest “niezainteresowany”, a poprzednio wystąpił status “zainteresowany”
 
SELECT
	COUNT(*) AS zainteresowani_utraty,
    SUBSTRING(t.curr_time,1,10) AS data_osiagniecia_statusu
FROM
	(
    SELECT
		c1.klient_id AS klient1,
		c2.klient_id AS klient2,
		c1.stat  AS curr_stat,
		c2.stat AS prev_stat, 
		c1.ts AS curr_time,
		RANK() OVER(partition by c1.klient_id order by c1.ts DESC) AS a
    FROM
		contacts c1
        INNER JOIN
			contacts c2 ON c2.id = c1.id - 1
    ) AS t
WHERE
    t.curr_stat = 'not_interested' AND t.prev_stat = 'interested'
      
    AND t.klient1 = t.klient2  AND a = 1
GROUP BY
	t.curr_time;
    
-- ----------------------------------------------------------------------
-- niezainteresowani_sukcesy - liczba klientów, których ostatnim statusem jest “zainteresowany”, a poprzednio wystąpił status “niezainteresowany”
SELECT
 	COUNT(*) AS niezainteresowani_sukcesy,
    SUBSTRING(t.curr_time,1,10) AS data_osiagniecia_statusu
FROM
	(
    SELECT
		c1.klient_id AS klient1,
		c2.klient_id AS klient2,
		c1.stat  AS curr_stat,
		c2.stat AS prev_stat,
		c1.ts AS curr_time,
		RANK() OVER(partition by c1.klient_id order by c1.ts DESC) AS a
    FROM
		contacts c1
        INNER JOIN
			contacts c2 ON c2.id = c1.id - 1
    ) AS t
WHERE
    t.curr_stat = 'interested' AND 
    t.prev_stat = 'not_interested' AND 
    t.klient1 = t.klient2 AND 
    a = 1
GROUP BY
    t.curr_time;



    
 