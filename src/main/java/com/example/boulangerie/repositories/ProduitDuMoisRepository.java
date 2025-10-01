package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.ProduitDuMois;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProduitDuMoisRepository extends JpaRepository<ProduitDuMois, Integer> {
    
    @Query("SELECT pdm FROM ProduitDuMois pdm WHERE pdm.mois = :mois AND pdm.annee = :annee")
    List<ProduitDuMois> findByMoisAndAnnee(@Param("mois") Integer mois, @Param("annee") Integer annee);
    
    @Query("SELECT pdm FROM ProduitDuMois pdm WHERE :date BETWEEN pdm.dateDebut AND pdm.dateFin")
    List<ProduitDuMois> findCurrentPromos(@Param("date") LocalDate date);
    
    @Query("SELECT pdm FROM ProduitDuMois pdm WHERE pdm.produit.idProduit = :idProduit")
    List<ProduitDuMois> findByProduitId(@Param("idProduit") Integer idProduit);
    
    @Query("SELECT CASE WHEN COUNT(pdm) > 0 THEN true ELSE false END FROM ProduitDuMois pdm " +
           "WHERE pdm.produit.idProduit = :idProduit " +
           "AND ((pdm.dateDebut BETWEEN :dateDebut AND :dateFin) " +
           "OR (pdm.dateFin BETWEEN :dateDebut AND :dateFin))")
    boolean existsOverlappingPromotion(@Param("idProduit") Integer idProduit, 
                                     @Param("dateDebut") LocalDate dateDebut, 
                                     @Param("dateFin") LocalDate dateFin);
    
    @Query("SELECT pdm FROM ProduitDuMois pdm " +
           "WHERE pdm.dateFin >= :today " +
           "AND pdm.dateFin <= :endDate " +
           "ORDER BY pdm.dateFin ASC")
    List<ProduitDuMois> findExpiringPromotions(@Param("today") LocalDate today, 
                                              @Param("endDate") LocalDate endDate);
    
    @Query("SELECT pdm FROM ProduitDuMois pdm " +
           "WHERE pdm.dateFin < :today")
    List<ProduitDuMois> findExpiredPromotions(@Param("today") LocalDate today);
}
