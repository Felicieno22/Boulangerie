package com.example.boulangerie.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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

@Entity
@Table(name = "commande")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Commande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcommande")
    @Getter
    private Integer idCommande;
    
    @Getter
    @Column(name = "datecommande" , nullable = false)
    private LocalDate dateCommande;
    
    @Column(name = "status" )
    private String status;
    
    @ManyToOne
    @JoinColumn(name = "idclient", nullable = false)
    private Client client;
    
    @OneToMany(mappedBy = "commande", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<CommandeProduit> commandeProduits = new ArrayList<>();
    
    @OneToMany(mappedBy = "commande")
    private List<Paiement> paiements;
    
    @OneToMany(mappedBy = "commande")
    private List<Evaluation> evaluations;

    public void addCommandeProduit(CommandeProduit commandeProduit) {
        commandeProduits.add(commandeProduit);
        commandeProduit.setCommande(this);
    }

}