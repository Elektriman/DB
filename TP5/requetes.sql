--Q1
/*
SELECT DISTINCT MU.nom, MU.prenom, MU.date_naissance, MU.date_deces, MU.instrument, G.nom as nom_groupe
FROM membres as ME
	LEFT JOIN musiciens as MU on MU.id_musicien=ME.musicien
	JOIN formations as F on F.id_formation=formation
		JOIN groupes as G on G.id_groupe=F.groupe
ORDER BY MU.nom ;
*/

--Q2
/*
SELECT DISTINCT L.nom, L.type_production, count(G.id_groupe) as nb_groupes, 20*sum(E.nombre_spectateur) as chiffre_affaire
	FROM evenements as E
		JOIN formations as F on F.id_formation=E.formation
			JOIN groupes as G on G.id_groupe=F.groupe
				JOIN labels as L on L.id_label=G.label
GROUP BY L.id_label
ORDER BY L.nom ;
*/

--facultatif
/*
SELECT DISTINCT G.nom as nom_groupe, avg(M.age) as age_moyenne
FROM groupes as G
	JOIN (
		SELECT DISTINCT MU.id_musicien, FF.groupe, (COALESCE(MU.date_deces, CURRENT_DATE)-MU.date_naissance)/365.25 as age 
		FROM musiciens as MU
			JOIN membres as MEME on MEME.musicien=MU.id_musicien
			JOIN formations as FF on FF.id_formation=MEME.formation
	) as M on M.groupe=G.id_groupe
GROUP BY nom_groupe
HAVING avg(M.age) < 60
ORDER BY nom_groupe ;
*/

--Q3
/*
SELECT MU.nom, MU.prenom, count(DISTINCT E.id_evenement) as nb_evenements, sum(E.nombre_spectateur) as nb_spectateurs
FROM membres as ME
	JOIN musiciens as MU on MU.id_musicien=ME.musicien
	JOIN evenements as E on E.formation=ME.formation
GROUP BY MU.nom, MU.prenom
ORDER BY MU.nom, MU.prenom ;
*/

--Q4
/*
SELECT G.nom, G.date_creation, count(DISTINCT F.id_formation) as nb_formations, count(DISTINCT ME.musicien) as nb_musiciens
FROM membres as ME
	JOIN formations as F on F.id_formation=ME.formation
		JOIN groupes as G on G.id_groupe=F.groupe
GROUP BY G.nom, G.date_creation
HAVING G.date_creation < '01/01/1981' ;
*/

--Q5
/*
SELECT *
FROM evenements as E
WHERE NOT EXISTS(
	SELECT 1
	FROM membres as ME
		LEFT JOIN musiciens as MU on MU.id_musicien=ME.musicien
		JOIN formations as F on F.id_formation=ME.formation
			JOIN evenements as EE on E.formation=F.id_formation
	WHERE MU.date_naissance > '01/01/1945'
		AND EE.id_evenement=E.id_evenement
);
*/

--Q6
/*
SELECT *
FROM labels as L
WHERE NOT EXISTS(
	SELECT 1
	FROM evenements as E
	WHERE E.lieu = 'USA-NY'
		AND NOT EXISTS(
		SELECT 1
		FROM evenements as EE
			JOIN formations as F on F.id_formation=EE.formation
				JOIN groupes as G on G.id_groupe=F.groupe
					JOIN labels as LL on LL.id_label=G.label
		WHERE EE.lieu=E.lieu
			AND LL.id_label=L.id_label
	)
);
*/




