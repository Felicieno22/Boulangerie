package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.TypeProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/produits")
public class ProduitController {
    @Autowired
    private ProduitService produitService;
    
    @Autowired
    private TypeProduitService typeProduitService;

    @GetMapping
    public String listProduits(
            @RequestParam(required = false) String searchNom,
            @RequestParam(required = false) String searchIngredient,
            Model model) {
        List<Produit> produits;
        
        if (searchIngredient != null && !searchIngredient.trim().isEmpty()) {
            produits = produitService.findByIngredient(searchIngredient);
        } else if (searchNom != null && !searchNom.trim().isEmpty()) {
            produits = produitService.findByNom(searchNom);
        } else {
            produits = produitService.findAll();
        }
        
        model.addAttribute("produits", produits);
        model.addAttribute("searchNom", searchNom);
        model.addAttribute("searchIngredient", searchIngredient);
        return "produit/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("produit", new Produit());
        model.addAttribute("typeProduits", typeProduitService.findAll());
        return "produit/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("produit", produitService.findById(id).orElseThrow());
        model.addAttribute("typeProduits", typeProduitService.findAll());
        return "produit/form";
    }

    @PostMapping("/save")
    public String saveProduit(@ModelAttribute Produit produit, @RequestParam(required = false) MultipartFile imageFile) {
        // Gérer l'upload de l'image si nécessaire
        produitService.save(produit);
        return "redirect:/produits";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduit(@PathVariable Integer id) {
        produitService.deleteById(id);
        return "redirect:/produits";
    }
} 