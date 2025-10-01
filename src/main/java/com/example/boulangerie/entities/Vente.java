package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "vente")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idvente")
    private Integer idVente;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idproduit", nullable = false)
    private Produit produit;
    
    @Column(name = "datevente", nullable = false)
    private LocalDate dateVente;
}