package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.Stock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StockRepository extends JpaRepository<Stock, Integer> {
    Optional<Stock> findByProduitIdProduit(Integer produitId);
    Optional<Stock> findByIngredient_IdIngredient(Integer ingredientId);
} 