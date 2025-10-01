package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.FormuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/formules/api")
@CrossOrigin(origins = "http://localhost:8080")
public class ProduitRestController {
    
    @Autowired
    private ProduitService produitService;
    
    @Autowired
    private FormuleService formuleService;

    @GetMapping("/produit/{id}")
    public ResponseEntity<Produit> getProduitById(@PathVariable Integer id) {
        return produitService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping(value = {"/produit", "/produit/"})
    public ResponseEntity<List<Produit>> getAllProduits() {
        List<Produit> produits = produitService.findAll();
        return ResponseEntity.ok(produits);
    }
    
    @GetMapping("/produit/{id}/formules")
    public ResponseEntity<List<Formule>> getFormulesForProduit(@PathVariable Integer id) {
        List<Formule> formules = formuleService.findByProduitId(id);
        if (formules.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(formules);
    }
} 