package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Stock;
import com.example.boulangerie.services.StockService;
import com.example.boulangerie.services.ProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/stocks")
public class StockController {
    @Autowired
    private StockService stockService;
    
    @Autowired
    private ProduitService produitService;

    @GetMapping
    public String listStocks(Model model) {
        model.addAttribute("stocks", stockService.findAll());
        return "stock/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("stock", new Stock());
        model.addAttribute("produits", produitService.findAll());
        return "stock/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("stock", stockService.findById(id).orElseThrow());
        model.addAttribute("produits", produitService.findAll());
        return "stock/form";
    }

    @PostMapping("/save")
    public String saveStock(@ModelAttribute Stock stock) {
        stockService.save(stock);
        return "redirect:/stocks";
    }

    @GetMapping("/delete/{id}")
    public String deleteStock(@PathVariable Integer id) {
        stockService.deleteById(id);
        return "redirect:/stocks";
    }
} 