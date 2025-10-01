package com.example.boulangerie.entities;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "produits_du_mois")
public class ProduitDuMois {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproduitMois")
    private Integer idProduitMois;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idproduit", nullable = false)
    private Produit produit;

    @Column(name = "mois", nullable = false)
    private Integer mois;

    @Column(name = "annee", nullable = false)
    private Integer annee;

    @Column(name = "description")
    private String description;

    @Column(name = "remise")
    private Double remise;

    @Column(name = "datedebut", nullable = false)
    private LocalDate dateDebut;

    @Column(name = "datefin", nullable = false)
    private LocalDate dateFin;

    // Getters and Setters
    public Integer getIdProduitMois() {
        return idProduitMois;
    }

    public void setIdProduitMois(Integer idProduitMois) {
        this.idProduitMois = idProduitMois;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public Integer getMois() {
        return mois;
    }

    public void setMois(Integer mois) {
        this.mois = mois;
    }

    public Integer getAnnee() {
        return annee;
    }

    public void setAnnee(Integer annee) {
        this.annee = annee;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getRemise() {
        return remise;
    }

    public void setRemise(Double remise) {
        this.remise = remise;
    }

    public LocalDate getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDate dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDate getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDate dateFin) {
        this.dateFin = dateFin;
    }
}
