package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "admin")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Admin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idadmin")
    @Getter
    private Integer idAdmin;
    
    @Getter
    @Column(name = "nomadmin", nullable = false)
    private String nomAdmin;
    
    @Getter
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    
    @Getter
    @Column(name = "password", nullable = false)
    private String password;
} 