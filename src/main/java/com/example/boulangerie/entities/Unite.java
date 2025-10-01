package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "unite")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Unite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idunite")
    private Integer idUnite;
    
    @Column(name = "unite", nullable = false)
    private String unite;
} 