-- Création de la vue pour la facture
DROP VIEW IF EXISTS VueFacture;

-- Création de la vue pour l'inventaire des produits
CREATE VIEW VueInventaireProduits AS
SELECT 
    p.nomProduit,
    s.quantiteStock,
    s.dateMaj
FROM 
    Produit p
JOIN 
    Stock s ON p.idProduit = s.idProduit;

-- Création de la vue pour les ventes par produit
CREATE VIEW VueVentesParProduit AS
SELECT 
    p.nomProduit,
    SUM(cp.quantite) AS QuantiteVendue,
    SUM(cp.quantite * p.prixVente) AS RevenuTotal
FROM 
    Produit p
JOIN 
    commandeProduit cp ON p.idProduit = cp.idProduit
GROUP BY 
    p.nomProduit;

-- Création de la vue pour les détails des commandes clients
CREATE VIEW VueDetailsCommandesClients AS
SELECT 
    c.idCommande,
    c.dateCommande,
    p.nomProduit,
    cp.quantite,
    p.prixVente,
    (cp.quantite * p.prixVente) AS TotalProduit
FROM 
    Commande c
JOIN 
    CommandeProduit cp ON c.idCommande = cp.idCommande
JOIN 
    Produit p ON cp.idProduit = p.idProduit;

-- Création de la vue pour l'analyse des coûts de production
CREATE VIEW VueAnalyseCoutsProduction AS
SELECT 
    p.nomProduit,
    SUM(f.quantite * i.prixRevient) AS CoutProduction
FROM 
    Produit p
JOIN 
    Formule f ON p.idProduit = f.idProduit
JOIN 
    Ingredient i ON f.idIngredient = i.idIngredient
GROUP BY 
    p.nomProduit;

-- Création de la vue pour les statistiques de ventes , montrer les revenus totaux, le nombre de commandes, et la quantité de produits vendus sur différentes périodes (journalière, hebdomadaire, mensuelle).
CREATE VIEW VueStatistiquesVentes AS
SELECT 
    DATE_FORMAT(c.dateCommande, '%Y-%m-%d') AS Date,
    COUNT(DISTINCT c.idCommande) AS NombreCommandes,
    SUM(cp.quantite) AS TotalProduitsVendus,
    SUM(cp.quantite * p.prixVente) AS RevenuTotal
FROM 
    Commande c
JOIN 
    CommandeProduit cp ON c.idCommande = cp.idCommande
GROUP BY 
    DATE_FORMAT(c.dateCommande, '%Y-%m-%d');

-- Création de la vue pour la performance des produits , Cette vue peut aider à identifier les produits les plus et les moins performants en termes de quantités vendues et de revenus générés.
CREATE VIEW VuePerformanceProduits AS
SELECT 
    p.nomProduit,
    SUM(cp.quantite) AS QuantiteVendue,
    SUM(cp.quantite * p.prixVente) AS Revenu
FROM 
    Produit p
JOIN 
    CommandeProduit cp ON p.idProduit = cp.idProduit
GROUP BY 
    p.nomProduit
ORDER BY 
    SUM(cp.quantite * p.prixVente) DESC;

-- Création de la vue pour les tendances des commandes
CREATE VIEW VueTendancesCommandes AS
SELECT 
    DATE_FORMAT(c.dateCommande, '%Y-%m') AS Mois,
    COUNT(*) AS NombreCommandes
FROM 
    Commande c
GROUP BY 
    DATE_FORMAT(c.dateCommande, '%Y-%m');


SELECT v.*, p.*, tp.* 
FROM Vente v
JOIN Produit p ON v.idProduit = p.idProduit
JOIN TypeProduit tp ON p.idTypeProduit = tp.idTypeProduit
WHERE p.idProduit = v.idProduit
ORDER BY v.dateVente DESC;