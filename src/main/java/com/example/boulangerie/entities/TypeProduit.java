package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Table(name = "typeproduit")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TypeProduit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtypeproduit")
    private Integer idTypeProduit;
    
    @Column(name = "nomtypeproduit" , nullable = false)
    private String nomTypeProduit;
} 