package com.example.boulangerie.entities;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "produit")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Produit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproduit")
    @Getter
    @Setter
    private Integer idProduit;
    
    @Getter
    @Setter
    @Column(name = "nomproduit")
    private String nomProduit;
    
    @Column(name = "prixrevient")
    private BigDecimal prixRevient;
    
    @Column(name = "prixvente")
    private BigDecimal prixVente;
    
    @Column(name = "image")
    private String image;
    
    @ManyToOne
    @JoinColumn(name = "idtypeproduit", nullable = false)
    private TypeProduit typeProduit;
    
    @OneToMany(mappedBy = "produit", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Formule> formules;
    
    @OneToMany(mappedBy = "produit", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Stock> stocks;

    // Manually added getters and setters if Lombok is not working
    public Integer getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(Integer idProduit) {
        this.idProduit = idProduit;
    }

    public String getNomProduit() {
        return nomProduit;
    }

    public void setNomProduit(String nomProduit) {
        this.nomProduit = nomProduit;
    }
}