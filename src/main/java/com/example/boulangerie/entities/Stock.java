package com.example.boulangerie.entities;

import java.math.BigDecimal;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "stock")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idstock")
    private Integer idStock;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idproduit")
    @JsonIgnoreProperties({"formules", "stocks"})
    @Getter
    @Setter
    private Produit produit;
    
    @ManyToOne
    @JoinColumn(name = "idingredient")
    private Ingredient ingredient;
    
    @Getter
    @Setter
    @Column(name = "quantitestock", nullable = false)
    private BigDecimal quantiteStock;
    
    @Getter
    @Setter
    @Column(name = "dateMaj")
    private LocalDate dateMaj;

    // Manually added getters and setters if Lombok is not working
    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public BigDecimal getQuantiteStock() {
        return quantiteStock;
    }

    public void setQuantiteStock(BigDecimal quantiteStock) {
        this.quantiteStock = quantiteStock;
    }

    public LocalDate getDateMaj() {
        return dateMaj;
    }

    public void setDateMaj(LocalDate dateMaj) {
        this.dateMaj = dateMaj;
    }
}