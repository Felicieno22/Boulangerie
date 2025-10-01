package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.services.FormuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/formules")
@CrossOrigin(origins = "http://localhost:8080")
public class FormuleRestController {
    
    @Autowired
    private FormuleService formuleService;

    @GetMapping("/produit/{produitId}")
    public ResponseEntity<List<Formule>> getFormulesByProduit(@PathVariable Integer produitId) {
        try {
            List<Formule> formules = formuleService.findByProduitId(produitId);
            if (formules.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(formules);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/produits/ingredient/nom/{nomIngredient}")
    public ResponseEntity<List<Produit>> getProduitsByIngredientNom(@PathVariable String nomIngredient) {
        try {
            List<Produit> produits = formuleService.getProduitsByIngredientNom(nomIngredient);
            if (produits.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(produits);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}