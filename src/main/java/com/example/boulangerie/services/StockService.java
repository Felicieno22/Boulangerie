package com.example.boulangerie.services;

import com.example.boulangerie.entities.Stock;
import com.example.boulangerie.repositories.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StockService {
    @Autowired
    private StockRepository stockRepository;

    public List<Stock> findAll() {
        return stockRepository.findAll();
    }

    public Optional<Stock> findById(Integer id) {
        return stockRepository.findById(id);
    }

    public Stock save(Stock stock) {
        return stockRepository.save(stock);
    }

    public void deleteById(Integer id) {
        stockRepository.deleteById(id);
    }

    public Optional<Stock> findByProduitId(Integer produitId) {
        return stockRepository.findByProduitIdProduit(produitId);
    }

    public Optional<Stock> findByIngredientId(Integer ingredientId) {
        return stockRepository.findByIngredient_IdIngredient(ingredientId);
    }
} 