-- ==========================================================
-- PROJET : Gestion des Opérations Pétrolières
-- AUTEUR : Oussama
-- OBJECTIF : Script complet (LDD/LMD) pour le TP2
-- ==========================================================

-- ----------------------------------------------------------
-- 1. CRÉATION DES TABLES (LDD)
-- ----------------------------------------------------------

CREATE TABLE Station (
    CodeSta VARCHAR(50) PRIMARY KEY NOT NULL,
    Ville VARCHAR(100),
    DateCreation DATE,
    SalaireDirecteur DECIMAL(10, 2)
);

CREATE TABLE Voiture (
    Matricule VARCHAR(50) PRIMARY KEY NOT NULL,
    Marque VARCHAR(100),
    Type VARCHAR(100)
);

CREATE TABLE Operation (
    NOper INT PRIMARY KEY NOT NULL,
    Type VARCHAR(100),
    DateOper DATE,
    Montant DECIMAL(10, 2),
    Matricule VARCHAR(50),
    CodeSta VARCHAR(50),
    FOREIGN KEY (Matricule) REFERENCES Voiture(Matricule),
    FOREIGN KEY (CodeSta) REFERENCES Station(CodeSta)
);

-- ----------------------------------------------------------
-- 2. INITIALISATION DES DONNÉES (Seeding)
-- ----------------------------------------------------------

INSERT INTO Station (CodeSta, Ville, DateCreation, SalaireDirecteur) VALUES
('Afriquia1', 'Beni Mellal', '2018-02-15', 45000.00),
('Afriquia2', 'Fkih Bensalah', '2017-05-20', 50000.00),
('Afriquia3', 'ELKSIBA', '2017-10-15', 60000.00),
('Afriquia4', 'Beni Mellal', '2017-05-11', 70000.00),
('Afriquia5', 'Beni Mellal', '2016-06-05', 40000.00);

INSERT INTO Voiture (Matricule, Marque, Type) VALUES
('A230070', 'Palio', 'Diesel'),
('A607878', 'Dacia', 'Essence'),
('A9000', 'palio', 'diesel'),
('B406767', 'Mercedes', 'Essence'),
('B670067', 'FIAT', 'Diesel');

INSERT INTO Operation (NOper, DateOper, Type, Montant, Matricule, CodeSta) VALUES
(1, '2017-08-15', 'Vidange', 200.00, 'A230070', 'Afriquia1'),
(2, '2017-09-15', 'CARBURANT', 500.00, 'A230070', 'Afriquia2'),
(3, '2017-07-06', 'Vidange', 300.00, 'A607878', 'Afriquia1'),
(4, '2017-07-07', 'CARBURANT', 300.00, 'B406767', 'Afriquia4'),
(5, '2018-02-15', 'CARBURANT', 400.00, 'A9000', 'Afriquia5'),
(6, '2018-01-15', 'Lissage', 70.00, 'A9000', 'Afriquia2');

-- ----------------------------------------------------------
-- 3. RÉPONSES AUX QUESTIONS DU TP
-- ----------------------------------------------------------

-- Q2 : Enregistrement d'une nouvelle opération
INSERT INTO Operation (NOper, DateOper, Type, Montant, Matricule, CodeSta) 
VALUES (7, '2018-01-10', 'Vidange', 600.00, 'B406767', 'Afriquia5');

-- Q3 : Affichage des stations de Beni Mellal
SELECT * FROM Station WHERE Ville = 'Beni Mellal';

-- Q4 : Voitures Diesel triées par marque (Décroissant)
SELECT * FROM Voiture WHERE Type = 'Diesel' ORDER BY Marque DESC;

-- Q5 : Nombre d'opérations pour la voiture 'A9000'
SELECT COUNT(*) AS Nombre_Operations FROM Operation WHERE Matricule = 'A9000';

-- Q6 : Augmentation des salaires de 1500 DH à Beni Mellal
UPDATE Station SET SalaireDirecteur = SalaireDirecteur + 1500 WHERE Ville = 'Beni Mellal';

-- Q7 : Somme des montants par station
SELECT CodeSta, SUM(Montant) AS Total_Montants FROM Operation GROUP BY CodeSta;

-- Q8 : Jointure - Infos pour les opérations 'Vidange'
SELECT V.Matricule, V.Marque, S.Ville
FROM Operation O
INNER JOIN Voiture V ON O.Matricule = V.Matricule
INNER JOIN Station S ON O.CodeSta = S.CodeSta
WHERE O.Type = 'Vidange';

-- Q9 : Voitures n'ayant jamais fait de 'CARBURANT'
SELECT * FROM Voiture 
WHERE Matricule NOT IN (SELECT Matricule FROM Operation WHERE Type = 'CARBURANT');

-- Q10 : Suppression des voitures sans opérations
DELETE FROM Voiture 
WHERE Matricule NOT IN (SELECT DISTINCT Matricule FROM Operation);
