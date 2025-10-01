package com.example.boulangerie.entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "suivi_modifs")
public class SuiviModifs {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsuivimodif")
    private Integer idSuiviModif;

    @Column(name = "datemodif", nullable = false)
    private LocalDateTime dateModif;

    @Column(name = "typeoperation", nullable = false)
    private String typeOperation;

    @Column(name = "tableconcernee", nullable = false)
    private String tableConcernee;

    @Column(name = "anciennevaleur")
    private String ancienneValeur;

    @Column(name = "nouvellevaleur")
    private String nouvelleValeur;

    // Getters and Setters
    public Integer getIdSuiviModif() {
        return idSuiviModif;
    }

    public void setIdSuiviModif(Integer idSuiviModif) {
        this.idSuiviModif = idSuiviModif;
    }

    public LocalDateTime getDateModif() {
        return dateModif;
    }

    public void setDateModif(LocalDateTime dateModif) {
        this.dateModif = dateModif;
    }

    public String getTypeOperation() {
        return typeOperation;
    }

    public void setTypeOperation(String typeOperation) {
        this.typeOperation = typeOperation;
    }

    public String getTableConcernee() {
        return tableConcernee;
    }

    public void setTableConcernee(String tableConcernee) {
        this.tableConcernee = tableConcernee;
    }

    public String getAncienneValeur() {
        return ancienneValeur;
    }

    public void setAncienneValeur(String ancienneValeur) {
        this.ancienneValeur = ancienneValeur;
    }

    public String getNouvelleValeur() {
        return nouvelleValeur;
    }

    public void setNouvelleValeur(String nouvelleValeur) {
        this.nouvelleValeur = nouvelleValeur;
    }
}
