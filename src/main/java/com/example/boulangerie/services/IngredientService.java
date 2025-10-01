package com.example.boulangerie.services;

import com.example.boulangerie.entities.Ingredient;
import com.example.boulangerie.repositories.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class IngredientService {
    @Autowired
    private IngredientRepository ingredientRepository;

    public List<Ingredient> findAll() {
        return ingredientRepository.findAll();
    }

    public Optional<Ingredient> findById(Integer id) {
        return ingredientRepository.findById(id);
    }

    public Ingredient save(Ingredient ingredient) {
        return ingredientRepository.save(ingredient);
    }

    @Transactional
    public void deleteById(Integer id) {
        ingredientRepository.deleteById(id);
    }

    public List<Ingredient> findByNom(String nom) {
        if (nom == null || nom.trim().isEmpty()) {
            return findAll();
        }
        return ingredientRepository.findByNomContainingIgnoreCase(nom.trim());
    }

    public List<Ingredient> findByProduit(String nomProduit) {
        if (nomProduit == null || nomProduit.trim().isEmpty()) {
            return findAll();
        }
        return ingredientRepository.findByProduit(nomProduit.trim());
    }
}