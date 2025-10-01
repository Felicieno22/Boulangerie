package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.entities.Produit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;
import java.util.List;

@Repository
public interface FormuleRepository extends JpaRepository<Formule, Integer> {
    @Query("SELECT f FROM Formule f LEFT JOIN FETCH f.ingredient i LEFT JOIN FETCH i.unite WHERE f.produit.idProduit = :idProduit")
    List<Formule> findByProduitIdProduit(@Param("idProduit") Integer idProduit);

    @Query("SELECT f.produit FROM Formule f WHERE f.ingredient.nomIngredient = :nomIngredient")
    List<Produit> findProduitsByIngredientNom(@Param("nomIngredient") String nomIngredient);
}  