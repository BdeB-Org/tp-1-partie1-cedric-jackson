-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: Jackson Filostin                       Votre DA: 2390032
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC outils_emprunt;
DESC outils_outil;
DESC outils_usager ;


-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT  CONCAT (prenom,' ',nom_famille) As " Prenom et nom de famille"
FROM outils_usager;


-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2

SELECT DISTINCT ville
FROM outils_usager
ORDER By ville;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
from outils_outil
ORDER BY nom, code_outil;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2

SELECT NUM_EMPRUNT AS "num�ro d'emprunt"
FROM OUTILS_EMPRUNT 
WHERE DATE_RETOUR IS NULL;


-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3

SELECT NUM_EMPRUNT AS "num�ro d'emprunt"
FROM OUTILS_EMPRUNT 
WHERE DATE_EMPRUNT < to_date('2014-01-01', 'YYYY-MM-DD');

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3

SELECT nom AS "Nom de tous les outils" ,code_outil AS "Code de tous les outils"
FROM outils_outil
WHERE UPPER (caracteristiques) LIKE ('%J%');


-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT nom AS "Nom de tous les outils" ,code_outil AS "Code de tous les outils"
FROM outils_outil
WHERE UPPER(fabricant) = 'STANLEY';


-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2

SELECT nom AS "Nom de tous les outils", fabricant AS "Fabricant de tous les outils" 
FROM outils_outil
WHERE annee BETWEEN 2006 AND 2008;


-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3

SELECT code_outil AS"Code de tous les outils", nom AS"Nom de tous les outils"
FROM outils_outil
WHERE caracteristiques NOT LIKE ('%20%');

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2

SELECT nom 
FROM outils_outil
WHERE UPPER(fabricant) NOT LIKE('%M%');

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5


SELECT CONCAT(outils_usager.nom_famille, ' ', outils_usager.prenom) AS "Nom du client",
       outils_emprunt.num_emprunt AS "Numero de l'emprunt",
       COALESCE(outils_emprunt.date_retour - outils_emprunt.date_emprunt, 0) AS "Dur�e de l'emprunt",
       COALESCE(outils_outil.prix, 0) AS "Prix de l'outil"
FROM outils_usager
JOIN outils_emprunt ON outils_emprunt.num_usager = outils_usager.num_usager
JOIN outils_outil ON outils_emprunt.code_outil = outils_outil.code_outil
WHERE UPPER(outils_usager.ville) IN ('VANCOUVER', 'REGINA');



-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4

Select nom, outils_emprunt.code_outil
FROM outils_outil
INNER JOIN outils_emprunt
ON outils_emprunt.code_outil = outils_outil.code_outil
WHERE date_retour IS NOT NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3

SELECT
NOM_FAMILLE AS Nom,
PRENOM AS Pr�nom,
COURRIEL AS Courriel
FROM OUTILS_USAGER
WHERE NUM_USAGER NOT IN (SELECT DISTINCT NUM_USAGER FROM OUTILS_EMPRUNT);

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4

SELECT outils_outil.code_outil "Code de l'outil" , 
COALESCE(prix, 0) AS "Valeur de tous les outils"  
FROM outils_outil
LEFT OUTER JOIN outils_emprunt
ON outils_emprunt.code_outil = outils_outil.code_outil
WHERE  outils_emprunt.code_outil IS NULL;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT CONCAT(nom , ' ', COALESCE (prix, 
(SELECT AVG (prix) FROM outils_outil) ))AS "Liste de tous les outils" 
FROM outils_outil
WHERE prix > (SELECT AVG(prix) FROM outils_outil) 
AND UPPER(fabricant)= 'MAKITA';


-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4

SELECT DISTINCT nom_famille AS "Non de famille" , prenom AS "Prenom", 
adresse AS "Adresse du client" , nom AS "Nom de l'outil", 
outils_outil.code_outil AS "Code de l'outil"
FROM outils_usager
JOIN outils_emprunt
ON outils_emprunt.num_usager = outils_usager.num_usager 
JOIN outils_outil
ON  outils_emprunt.code_outil = outils_outil.code_outil 
WHERE TO_CHAR(date_emprunt, 'YYYY') > '2014';

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4

SELECT  nom "Nom de tous les outils", MAX(prix) "Prix de tous les outils" 
FROM outils_outil
GROUP BY nom 
HAVING COUNT (code_outil) > 1

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
    SELECT DISTINCT
OUTILS_USAGER.PRENOM AS Pr�nom,
OUTILS_USAGER.NOM_FAMILLE AS Nom,
OUTILS_USAGER.ADRESSE AS Adresse,
OUTILS_USAGER.VILLE AS Ville
FROM OUTILS_USAGER
JOIN OUTILS_EMPRUNT
ON OUTILS_USAGER.NUM_USAGER = OUTILS_EMPRUNT.NUM_USAGER;
--  IN
SELECT
OUTILS_USAGER.PRENOM AS Pr�nom,
NOM_FAMILLE AS Nom,
ADRESSE AS Adresse,
VILLE AS Ville
FROM OUTILS_USAGER
WHERE NUM_USAGER IN (
SELECT NUM_USAGER
FROM OUTILS_EMPRUNT);  
--  EXISTS
SELECT
PRENOM AS Pr�nom,
NOM_FAMILLE AS Nom,
ADRESSE AS Adresse,
VILLE AS Ville
FROM OUTILS_USAGER    
WHERE EXISTS (SELECT 1
FROM OUTILS_EMPRUNT
WHERE OUTILS_USAGER.NUM_USAGER = OUTILS_EMPRUNT.NUM_USAGER);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT AVG (prix) AS "Moyenne des prix" , fabricant
FROM outils_outil
GROUP BY fabricant


-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT ville , SUM(prix) AS "Somme de tous les prix" 
FROM outils_usager
JOIN outils_emprunt
ON outils_emprunt.num_usager = outils_usager.num_usager 
JOIN outils_outil
ON  outils_emprunt.code_outil = outils_outil.code_outil 
WHERE outils_outil.code_outil IN ( SELECT code_outil FROM outils_emprunt)
GROUP BY ville
ORDER BY  SUM(prix) DESC


-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL,NOM,FABRICANT,CARACTERISTIQUES,ANNEE,PRIX)
VALUES('1590','basket','orange','ball, noir,
','2066','123');


-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2

INSERT INTO OUTILS_OUTIL (CODE_OUTIL,NOM,ANNEE)
VALUES('239002','food','999');


-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM outils_outil
WHERE fabricant  = 'orange' OR  fabricant IS NULL


-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2


UPDATE outils_usager
SET nom_famille = UPPER(nom_famille);