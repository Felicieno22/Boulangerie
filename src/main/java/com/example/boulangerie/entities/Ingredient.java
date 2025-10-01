package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "ingredient")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ingredient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idingredient")
    private Integer idIngredient;
    
    @Column(name = "nomingredient", nullable = false)
    private String nomIngredient;
    
    @ManyToOne
    @JoinColumn(name = "idunite", nullable = false)
    private Unite unite;

    @OneToMany(mappedBy = "ingredient")
    private List<Formule> formules;
} 