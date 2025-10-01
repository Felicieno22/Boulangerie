package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.services.FormuleService;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.IngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/formules")
public class FormuleController {
    @Autowired
    private FormuleService formuleService;
    
    @Autowired
    private ProduitService produitService;
    
    @Autowired
    private IngredientService ingredientService;

    @GetMapping
    public String listFormules(Model model) {
        try {
            model.addAttribute("formules", formuleService.findAll());
            model.addAttribute("produits", produitService.findAll());
            model.addAttribute("ingredients", ingredientService.findAll());
            return "formule/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Une erreur est survenue lors du chargement des formules");
            model.addAttribute("formules", Collections.emptyList());
            return "formule/list";
        }
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("formule", new Formule());
        model.addAttribute("produits", produitService.findAll());
        model.addAttribute("ingredients", ingredientService.findAll());
        return "formule/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("formule", formuleService.findById(id).orElseThrow());
        model.addAttribute("produits", produitService.findAll());
        model.addAttribute("ingredients", ingredientService.findAll());
        return "formule/form";
    }

    @PostMapping("/save")
    public String saveFormule(@ModelAttribute Formule formule) {
        formuleService.save(formule);
        return "redirect:/formules";
    }

    @GetMapping("/delete/{id}")
    public String deleteFormule(@PathVariable Integer id) {
        formuleService.deleteById(id);
        return "redirect:/formules";
    }

    @GetMapping("/api/produit/{produitId}")
    @ResponseBody
    public ResponseEntity<List<Formule>> getFormulesByProduit(@PathVariable Integer produitId) {
        try {
            List<Formule> formules = formuleService.findByProduitId(produitId);
            if (formules.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(formules);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // New endpoint to find products by ingredient name
    @GetMapping("/api/produits/ingredient/nom/{nomIngredient}")
    @ResponseBody
    public ResponseEntity<List<Produit>> getProduitsByIngredientNom(@PathVariable String nomIngredient) {
        try {
            List<Produit> produits = formuleService.getProduitsByIngredientNom(nomIngredient);
            if (produits.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(produits);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}