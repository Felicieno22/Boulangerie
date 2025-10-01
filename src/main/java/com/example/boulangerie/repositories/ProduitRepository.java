package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.Produit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProduitRepository extends JpaRepository<Produit, Integer> {
    
    @Query("SELECT p FROM Produit p WHERE p.typeProduit.idTypeProduit = :idTypeProduit")
    List<Produit> findByTypeProduit(@Param("idTypeProduit") Integer idTypeProduit);
    
    @Query("SELECT DISTINCT p FROM Produit p " +
           "JOIN p.formules f " +
           "JOIN f.ingredient i " +
           "WHERE LOWER(i.nomIngredient) LIKE LOWER(CONCAT('%', :ingredient, '%'))")
    List<Produit> findByIngredient(@Param("ingredient") String ingredient);
    
    @Query("SELECT DISTINCT p FROM Produit p " +
           "WHERE LOWER(p.nomProduit) LIKE LOWER(CONCAT('%', :nom, '%'))")
    List<Produit> findByNomContainingIgnoreCase(@Param("nom") String nom);
    
    @Query("SELECT p FROM Produit p ORDER BY p.typeProduit.nomTypeProduit, p.nomProduit")
    List<Produit> findAllOrderByTypeAndNom();
}