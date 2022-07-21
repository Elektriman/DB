--Q1
/*
SELECT R.nointerv, SUM(P.prixht*R.qteremplacee) as piecesremp
FROM Remplacements as R
	JOIN Produits as P on P.reference=R.reference
GROUP BY R.nointerv
*/

--Q2
/*
SELECT I.nofacture, sum(I.temps*T.txhoraire) as maindoeuvre
FROM Interventions as I
	JOIN Tauxhoraire as T on T.codetaux=I.codetaux
GROUP BY I.nofacture
*/

--Q3
/*
SELECT I.nofacture, SUM(P.prixht*R.qteremplacee) as piecesremplacees
FROM Remplacements as R
	JOIN Produits as P on P.reference=R.reference
	JOIN Interventions as I on I.nointerv=R.nointerv
GROUP BY I.nofacture
*/

--Q4
/*
SELECT I.nofacture, SUM(DISTINCT montant) as resultat
FROM Interventions as I
	JOIN ((
		SELECT II.nofacture, sum(II.temps*T.txhoraire) as montant
		FROM Interventions as II
			JOIN Tauxhoraire as T on T.codetaux=II.codetaux
		GROUP BY II.nofacture
		) UNION (
		SELECT III.nofacture, SUM(PP.prixht*R.qteremplacee) as montant
		FROM Remplacements as R
			JOIN Produits as PP on PP.reference=R.reference
			JOIN Interventions as III on III.nointerv=R.nointerv
		GROUP BY III.nofacture)) as U on U.nofacture=I.nofacture
GROUP BY I.nofacture
*/