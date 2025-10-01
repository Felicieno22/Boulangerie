package com.example.boulangerie.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "mvtstock")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MvtStock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idmvtstock")
    private Integer idMvtStock;
    
    @Column(name = "typemouvement", nullable = false)
    private String typeMouvement;  // "ENTREE" ou "SORTIE"
    
    @Column(name = "quantite", nullable = false)
    private BigDecimal quantite;
    
    @Column(name = "datemvt", nullable = false)
    private LocalDate dateMvt;
    
    @ManyToOne
    @JoinColumn(name = "idstock", nullable = false)
    private Stock stock;
} 