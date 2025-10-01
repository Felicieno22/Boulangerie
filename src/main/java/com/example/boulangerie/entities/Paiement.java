package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;


@Entity
@Table(name = "paiement")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Paiement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpaiement")
    private Integer idPaiement;
    
    @Column(name = "montant" , nullable = false)
    private BigDecimal montant;
    
    @Column(name = "datepaiement" , nullable = false)
    private LocalDate datePaiement;
    
    @Column(name = "methode" , nullable = false)
    private String methode;
    
    @ManyToOne
    @JoinColumn(name = "idcommande", nullable = false)
    private Commande commande;
} 