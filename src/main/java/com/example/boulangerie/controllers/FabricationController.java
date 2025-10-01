package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Formule;
import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.entities.Stock;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.FormuleService;
import com.example.boulangerie.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/fabrication")
public class FabricationController {
    @Autowired
    private ProduitService produitService;
    
    @Autowired
    private FormuleService formuleService;
    
    @Autowired
    private StockService stockService;

    @GetMapping
    public String showFabricationPage(Model model) {
        model.addAttribute("produits", produitService.findAll());
        return "fabrication/index";
    }

    @PostMapping("/generer")
    public String genererFabrication(@RequestParam Integer produitId, 
                                   @RequestParam Double quantite,
                                   RedirectAttributes redirectAttributes) {
        try {
            // Convertir la quantité en BigDecimal
            BigDecimal quantiteBD = new BigDecimal(quantite.toString());
            
            // 1. Récupérer le produit et ses formules
            Produit produit = produitService.findById(produitId)
                .orElseThrow(() -> new RuntimeException("Produit non trouvé"));
            List<Formule> formules = formuleService.findByProduitId(produitId);
            
            if (formules.isEmpty()) {
                throw new RuntimeException("Aucune formule trouvée pour ce produit");
            }

            // 2. Mettre à jour le stock du produit
            Stock stockProduit = stockService.findByProduitId(produitId)
                .orElse(new Stock());
            
            stockProduit.setProduit(produit);
            if (stockProduit.getQuantiteStock() == null) {
                stockProduit.setQuantiteStock(quantiteBD);
            } else {
                stockProduit.setQuantiteStock(stockProduit.getQuantiteStock().add(quantiteBD));
            }
            stockProduit.setDateMaj(LocalDate.now());
            stockService.save(stockProduit);

            redirectAttributes.addFlashAttribute("success", 
                "Fabrication réussie de " + quantite + " " + produit.getNomProduit());
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
        }
        
        return "redirect:/fabrication";
    }
} 