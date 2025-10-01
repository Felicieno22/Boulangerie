package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;


@Entity
@Table(name = "evaluation")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Evaluation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idevaluation")
    private Integer idEvaluation;
    
    @Column(name = "satisfaction")
    private String satisfaction;

    @Column(name = "commentaire")
    private String commentaire;
    
    @Column(name = "dateevaluation" , nullable = false)
    private LocalDate dateEvaluation;
    
    @ManyToOne
    @JoinColumn(name = "idcommande", nullable = false)
    private Commande commande;
} 