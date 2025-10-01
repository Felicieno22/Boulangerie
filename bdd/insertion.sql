-- Insertion des unités de mesure
INSERT INTO Unite (Unite) 
VALUES 
('Kilogramme'),
('Litre'),
('Piece'),
('Grammes');

-- Insertion des types de produits
INSERT INTO typeProduit (nomTypeProduit) VALUES 
('Viennoiserie Nature'),
('Viennoiserie Fourrée'),
('Pain Tradition'),
('Pain Spéciaux'),
('Pâtisserie'),
('Sandwich');

-- Insertion des ingrédients
INSERT INTO Ingredient (nomIngredient, idUnite) 
VALUES 
('Farine', 1),
('Sucre', 4),
('Beurre', 1),
('Levure', 4),
('Lait', 2),
('Chocolat', 1),
('oeufs', 3);

-- Insertion des produits
INSERT INTO Produit (nomProduit, prixRevient, prixVente, image, idTypeProduit) VALUES
-- Viennoiserie Nature (Type 1)
('Croissant Nature', 1000, 2000, 'https://example.com/croissant.jpg', 1),
('Pain au Chocolat Nature', 1200, 2500, 'https://example.com/pain-chocolat.jpg', 1),
('Brioche Nature', 800, 1800, 'https://example.com/brioche.jpg', 1),
('Pain au Lait Nature', 900, 2000, 'https://example.com/pain-au-lait.jpg', 1),
('Palmier Nature', 1100, 2300, 'https://example.com/palmier.jpg', 1),
('Tresse Nature', 1300, 2800, 'https://example.com/tresse.jpg', 1),
('Brioche Tressée Nature', 1500, 3000, 'https://example.com/brioche-tressee.jpg', 1),
('Pain Suisse Nature', 1400, 2800, 'https://example.com/pain-suisse.jpg', 1);

-- Insertion des formules (recettes)
INSERT INTO Formule (quantite, idProduit, idIngredient) VALUES
-- Croissant Nature
(0.5, 1, 1), -- Farine
(0.2, 1, 2), -- Sucre
(0.1, 1, 3), -- Beurre

-- Pain au Chocolat Nature
(0.25, 2, 4), -- Levure
(0.1, 2, 5),  -- Lait
(0.05, 2, 6), -- Chocolat

-- Brioche Nature
(0.4, 3, 1),  -- Farine
(0.3, 3, 2),  -- Sucre
(0.2, 3, 3),  -- Beurre

-- Pain au Lait Nature
(0.3, 4, 5),  -- Lait
(0.2, 4, 1),  -- Farine
(0.1, 4, 7),  -- Oeufs

-- Palmier Nature
(0.3, 5, 1),  -- Farine
(0.2, 5, 3),  -- Beurre
(0.1, 5, 2);  -- Sucre

-- Données de test pour les produits du mois
INSERT INTO produits_du_mois (idProduit, dateDebut, dateFin, remise) VALUES
-- Promotions en cours
(1, '2025-01-01', '2025-01-31', 20),  -- Croissant Nature
(4, '2025-01-01', '2025-01-31', 15),  -- Pain au Lait Nature

-- Promotions qui expirent bientôt
(2, '2025-01-01', '2025-01-20', 25),  -- Pain au Chocolat Nature
(3, '2025-01-01', '2025-01-21', 30),  -- Brioche Nature

-- Promotions expirées
(5, '2024-12-01', '2024-12-31', 20),  -- Palmier Nature
(6, '2024-12-01', '2024-12-31', 15),  -- Tresse Nature

-- Promotions futures
(7, '2025-02-01', '2025-02-28', 10),  -- Brioche Tressée Nature
(8, '2025-02-01', '2025-02-28', 25);  -- Pain Suisse Nature