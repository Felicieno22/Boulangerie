package com.example.boulangerie.entities;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name = "formule")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Formule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idformule")
    private Integer idFormule;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idproduit")
    @JsonIgnoreProperties({"formules", "stocks"})
    private Produit produit;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idingredient")
    @JsonIgnoreProperties("formules")
    private Ingredient ingredient;
    
    @Column(name = "quantite")
    private BigDecimal quantite;
    
    // Getters et setters
} 