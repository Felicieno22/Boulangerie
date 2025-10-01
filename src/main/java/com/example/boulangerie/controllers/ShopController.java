package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.entities.Stock;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/shop")
public class ShopController {
    @Autowired
    private ProduitService produitService;
    
    @Autowired
    private StockService stockService;

    @GetMapping
    public String showShop(Model model) {
        List<Produit> produits = produitService.findAll();
        
        // Récupérer les stocks pour chaque produit
        Map<Integer, Stock> stockMap = new HashMap<>();
        for (Produit produit : produits) {
            stockService.findByProduitId(produit.getIdProduit())
                .ifPresent(stock -> stockMap.put(produit.getIdProduit(), stock));
        }
        
        model.addAttribute("produits", produits);
        model.addAttribute("stocks", stockMap);
        return "shop/index";
    }
} 