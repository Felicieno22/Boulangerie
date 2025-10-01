package com.example.boulangerie.services;

import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.repositories.ProduitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ProduitService {
    @Autowired
    private ProduitRepository produitRepository;

    public List<Produit> findAll() {
        return produitRepository.findAll();
    }

    public Optional<Produit> findById(Integer id) {
        return produitRepository.findById(id);
    }

    public Produit save(Produit produit) {
        return produitRepository.save(produit);
    }

    @Transactional
    public void deleteById(Integer id) {
        Produit produit = produitRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Produit non trouvé"));
            
        // La suppression en cascade s'occupera automatiquement des formules et stocks
        produitRepository.delete(produit);
    }

    public List<Produit> findByIngredient(String ingredient) {
        if (ingredient == null || ingredient.trim().isEmpty()) {
            return findAll();
        }
        return produitRepository.findByIngredient(ingredient.trim());
    }

    public List<Produit> findByNom(String nom) {
        if (nom == null || nom.trim().isEmpty()) {
            return findAll();
        }
        return produitRepository.findByNomContainingIgnoreCase(nom.trim());
    }
}