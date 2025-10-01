package com.example.boulangerie.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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

@Entity
@Table(name = "commandeproduit")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommandeProduit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcommandeproduit")
    @Getter
    private Integer idCommandeProduit;
    
    @Getter
    @Column(name = "quantite" , nullable = false)
    private Integer quantite;
    
    @ManyToOne
    @JoinColumn(name = "idcommande", nullable = false)
    @Getter
    private Commande commande;
    
    @ManyToOne
    @JoinColumn(name = "idproduit", nullable = false)
    @Getter
    private Produit produit;

    public void setCommande(Commande commande) {
        this.commande = commande;
    }
}