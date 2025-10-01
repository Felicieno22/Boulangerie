package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.Ingredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {
    
    @Query("SELECT DISTINCT i FROM Ingredient i " +
           "JOIN i.formules f " +
           "WHERE LOWER(f.produit.nomProduit) LIKE LOWER(CONCAT('%', :nomProduit, '%'))")
    List<Ingredient> findByProduit(@Param("nomProduit") String nomProduit);
    
    @Query("SELECT DISTINCT i FROM Ingredient i " +
           "WHERE LOWER(i.nomIngredient) LIKE LOWER(CONCAT('%', :nom, '%'))")
    List<Ingredient> findByNomContainingIgnoreCase(@Param("nom") String nom);
}