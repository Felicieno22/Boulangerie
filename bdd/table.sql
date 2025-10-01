CREATE DATABASE boulangerie;

\c boulangerie;

-- Activer les extensions nécessaires
CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE Admin(
   idAdmin SERIAL,
   nomAdmin VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idAdmin)
);

CREATE TABLE Proprietaire(
   idProprietaire SERIAL,
   nomProprietaire VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idProprietaire)
);

CREATE TABLE Unite(
   idUnite SERIAL,
   Unite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idUnite)
);

CREATE TABLE typeProduit(
   idTypeProduit SERIAL,
   nomTypeProduit VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idTypeProduit)
);

CREATE TABLE Client(
   idClient SERIAL,
   nomClient VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   telephone VARCHAR(50)  NOT NULL,
   adresse VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idClient)
);

CREATE TABLE Ingredient(
   idIngredient SERIAL,
   nomIngredient VARCHAR(50)  NOT NULL,
   idUnite INTEGER NOT NULL,
   PRIMARY KEY(idIngredient),
   FOREIGN KEY(idUnite) REFERENCES Unite(idUnite)
);

CREATE TABLE Produit(
   idProduit SERIAL,
   nomProduit VARCHAR(255)  NOT NULL,
   prixRevient NUMERIC(15,2)   NOT NULL,
   prixVente NUMERIC(15,2)   NOT NULL,
   image VARCHAR(150) ,
   idTypeProduit INTEGER NOT NULL,
   PRIMARY KEY(idProduit),
   FOREIGN KEY(idTypeProduit) REFERENCES typeProduit(idTypeProduit)
);

CREATE TABLE Stock(
   idStock SERIAL,
   quantiteStock NUMERIC(15,2)   NOT NULL,
   dateMaj DATE,
   idProduit INTEGER NOT NULL,
   PRIMARY KEY(idStock),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE mvtStock(
   idMvtStock SERIAL,
   typeMouvement VARCHAR(50) NOT NULL,
   quantite NUMERIC(15,2) NOT NULL,
   dateMvt DATE NOT NULL,
   idStock INTEGER NOT NULL,
   PRIMARY KEY(idMvtStock),
   FOREIGN KEY(idStock) REFERENCES Stock(idStock)
);

CREATE TABLE Formule(
   idFormule SERIAL,
   quantite NUMERIC(15,2)   NOT NULL,
   idProduit INTEGER NOT NULL,
   idIngredient INTEGER NOT NULL,
   PRIMARY KEY(idFormule),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit),
   FOREIGN KEY(idIngredient) REFERENCES Ingredient(idIngredient)
);

CREATE TABLE Commande(
   idCommande SERIAL,
   dateCommande DATE NOT NULL,
   status VARCHAR(1000) ,
   idClient INTEGER NOT NULL,
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idClient) REFERENCES Client(idClient)
);

CREATE TABLE commandeProduit(
   idCommandeProduit SERIAL,
   quantite INTEGER NOT NULL,
   idCommande INTEGER NOT NULL,
   idProduit INTEGER NOT NULL,
   PRIMARY KEY(idCommandeProduit),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE Paiement(
   idPaiement SERIAL,
   montant NUMERIC(15,2)   NOT NULL,
   datePaiement DATE NOT NULL,
   methode VARCHAR(50)  NOT NULL,
   idCommande INTEGER NOT NULL,
   PRIMARY KEY(idPaiement),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE Evaluation(
   idEvaluation SERIAL,
   satisfaction VARCHAR(255) ,
   commentaire VARCHAR(1000) ,
   dateEvaluation DATE NOT NULL,
   idCommande INTEGER NOT NULL,
   PRIMARY KEY(idEvaluation),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE vente(
   idVente SERIAL,
   idProduit INT NOT NULL,
   dateVente DATE NOT NULL,
   PRIMARY KEY(idVente),
   FOREIGN KEY (idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE suivi_modifs(
   idSuiviModif SERIAL,
   dateModif TIMESTAMP NOT NULL,
   typeOperation VARCHAR(50) NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
   tableConcernee VARCHAR(50) NOT NULL,
   ancienneValeur TEXT,
   nouvelleValeur TEXT,
   PRIMARY KEY(idSuiviModif)
);

CREATE TABLE produits_du_mois(
   idProduitMois SERIAL,
   idProduit INTEGER NOT NULL,
   dateDebut DATE NOT NULL,
   dateFin DATE NOT NULL,
   remise NUMERIC(5,2) NOT NULL CHECK (remise BETWEEN 0 AND 100),
   PRIMARY KEY(idProduitMois),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit),
   CONSTRAINT dates_valides CHECK (dateDebut <= dateFin),
   CONSTRAINT pas_de_chevauchement EXCLUDE USING gist (
      idProduit WITH =,
      daterange(dateDebut, dateFin, '[]') WITH &&
   )
);

-- Fonction pour suivre les modifications des formules et produits
CREATE OR REPLACE FUNCTION track_product_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF TG_TABLE_NAME = 'produit' THENDROP DATABASE IF EXISTS boulangerie;
            INSERT INTO suivi_modifs (
                dateModif,
                typeOperation,
                tableConcernee,
                nouvelleValeur
            ) VALUES (
                CURRENT_TIMESTAMP,
                'INSERT',
                'produit',
                'Nouveau produit ID: ' || NEW.idProduit || ', Nom: ' || NEW.nomProduit
            );
        ELSIF TG_TABLE_NAME = 'formule' THEN
            INSERT INTO suivi_modifs (
                dateModif,
                typeOperation,
                tableConcernee,
                nouvelleValeur
            ) VALUES (
                CURRENT_TIMESTAMP,
                'INSERT',
                'formule',
                'Nouvelle formule - Produit ID: ' || NEW.idProduit || ', Ingrédient ID: ' || NEW.idIngredient || ', Quantité: ' || NEW.quantite
            );
        END IF;
    ELSIF TG_OP = 'UPDATE' AND TG_TABLE_NAME = 'formule' THEN
        INSERT INTO suivi_modifs (
            dateModif,
            typeOperation,
            tableConcernee,
            ancienneValeur,
            nouvelleValeur
        ) VALUES (
            CURRENT_TIMESTAMP,
            'UPDATE',
            'formule',
            'Ancienne quantité: ' || OLD.quantite,
            'Nouvelle quantité: ' || NEW.quantite || ' pour Produit ID: ' || NEW.idProduit
        );
    ELSIF TG_OP = 'DELETE' AND TG_TABLE_NAME = 'formule' THEN
        INSERT INTO suivi_modifs (
            dateModif,
            typeOperation,
            tableConcernee,
            ancienneValeur
        ) VALUES (
            CURRENT_TIMESTAMP,
            'DELETE',
            'formule',
            'Suppression formule - Produit ID: ' || OLD.idProduit || ', Ingrédient ID: ' || OLD.idIngredient
        );
    END IF;
    
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        RETURN NEW;
    ELSE
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Création des triggers pour la table Produit
CREATE TRIGGER track_produit_changes
    AFTER INSERT ON Produit
    FOR EACH ROW
    EXECUTE FUNCTION track_product_changes();

-- Création des triggers pour la table Formule
CREATE TRIGGER track_formule_changes
    AFTER INSERT OR UPDATE OR DELETE ON Formule
    FOR EACH ROW
    EXECUTE FUNCTION track_product_changes();
