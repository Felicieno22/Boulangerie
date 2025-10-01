package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "proprietaire")
@Data
public class Proprietaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproprietaire")
    private Integer idProprietaire;
    
    @Column(name = "nomproprietaire" , nullable = false)
    private String nomProprietaire;
    
    @Column(name = "email" , nullable = false , unique = true)
    private String email;
    
    @Column(name = "password" , nullable = false)
    private String password;
} 