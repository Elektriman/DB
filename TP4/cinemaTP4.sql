--Q1
/*
SELECT I.nompers, count(V.nofilm) as nbre_films_vus
FROM Voir as V
	LEFT JOIN Individus as I on I.nopers=V.nospect
GROUP BY I.nopers ;
*/

--Q2
/*
SELECT I.nopers, I.nompers
FROM Individus as I
WHERE EXISTS
	(SELECT count(J.nofilm)
	 FROM Jouer as J
	 GROUP BY J.noacteur
	 HAVING count(nofilm)>3
	 	AND I.nopers=J.noacteur);
*/


--Q3
/*
SELECT F.nofilm, F.titre
FROM Films as F
	JOIN Aimer as A on A.nofilm=F.nofilm
GROUP BY F.nofilm
HAVING count(A.nospect)>10 ;
*/

--Q4
/*
SELECT F.titre, count(V.nospect) as nbre_spectateurs
FROM Films as F
	JOIN Voir as V on V.nofilm=F.nofilm
GROUP BY F.nofilm
HAVING count(V.nospect)<5 ;
*/

--Q5
/*
SELECT count(DISTINCT A.nospect) as nbre_films_de_matthieu_aimes
FROM Aimer as A
	JOIN Films as F on F.nofilm=A.nofilm
	JOIN Individus as I on I.nopers=F.norealisateur
GROUP BY I.nompers
HAVING I.nompers = 'Matthieu';
*/

--Q6
/*
SELECT count(DISTINCT J.noacteur) as nbre
FROM Jouer as J
	JOIN Films as F on F.noproducteur=J.noacteur
*/

--Q7
/*
SELECT I.nopers, I.nompers
FROM Jouer as J
	JOIN Individus as I on I.nopers=J.noacteur
WHERE EXISTS
	(SELECT 1
	 FROM Films as F
	 WHERE J.nofilm=F.nofilm
		 AND J.noacteur=F.noproducteur);
*/

--Q8
/*
SELECT I.nopers, I.nompers
FROM Individus as I
WHERE I.nopers IN (SELECT nospect FROM Voir)
	AND I.nopers NOT IN (SELECT nospect FROM Aimer);
*/

--Q9
/*
SELECT DISTINCT V.nofilm
FROM Voir as V
WHERE NOT EXISTS(
	SELECT 1
	FROM Aimer as A
	WHERE V.nofilm=A.nofilm);
*/

--Q10

SELECT F.noproducteur, I.nompers
FROM Films as F
	JOIN Individus as I on I.nopers=F.noproducteur
WHERE NOT EXISTS(
	SELECT 1
	FROM Films as FF
		JOIN Voir as V on V.nofilm=FF.nofilm
	WHERE V.nospect=F.noproducteur
		AND FF.noproducteur!=F.noproducteur);