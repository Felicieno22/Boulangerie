package com.example.boulangerie.repositories;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.boulangerie.entities.Vente;

@Repository
public interface VenteRepository extends JpaRepository<Vente, Integer> {
    
    @Query("SELECT v, p, tp FROM Vente v " +
           "JOIN v.produit p " +
           "JOIN p.typeProduit tp " +
           "WHERE tp.idTypeProduit = :idTypeProduit " +
           "ORDER BY p.nomProduit")
    List<Vente> findVenteParTypeProduit(@Param("idTypeProduit") Integer idTypeProduit);
    
    @Query("SELECT v FROM Vente v " +
           "JOIN v.produit p " +
           "JOIN p.typeProduit tp " +
           "WHERE p.idProduit = :idProduit " +
           "ORDER BY v.dateVente DESC")
    List<Vente> findVenteParProduit(@Param("idProduit") Integer idProduit);
    
    @Query("SELECT v, p, tp FROM Vente v " +
           "JOIN v.produit p " +
           "JOIN p.typeProduit tp " +
           "WHERE v.dateVente = :date " +
           "ORDER BY p.nomProduit")
    List<Vente> findVenteParDate(@Param("date") LocalDate date);
    
    @Query("SELECT v, p, tp FROM Vente v " +
           "JOIN v.produit p " +
           "JOIN p.typeProduit tp " +
           "ORDER BY tp.nomTypeProduit, p.nomProduit")
    List<Vente> findAllVente();
}
