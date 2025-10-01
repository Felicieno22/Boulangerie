package com.example.boulangerie.services;

import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.repositories.FormuleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class FormuleService {
    @Autowired
    private FormuleRepository formuleRepository;

    public List<Formule> findAll() {
        return formuleRepository.findAll();
    }

    public Optional<Formule> findById(Integer id) {
        return formuleRepository.findById(id);
    }

    public Formule save(Formule formule) {
        return formuleRepository.save(formule);
    }

    public void deleteById(Integer id) {
        formuleRepository.deleteById(id);
    }

    public List<Formule> findByProduitId(Integer produitId) {
        return formuleRepository.findByProduitIdProduit(produitId);
    }

    public List<Produit> getProduitsByIngredientNom(String nomIngredient) {
        return formuleRepository.findProduitsByIngredientNom(nomIngredient);
    }
}