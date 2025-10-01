package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.TypeProduit;
import com.example.boulangerie.services.TypeProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/typeproduits")
public class TypeProduitController {
    @Autowired
    private TypeProduitService typeProduitService;

    @GetMapping
    public String listTypeProduits(Model model) {
        model.addAttribute("typeProduits", typeProduitService.findAll());
        return "typeproduit/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("typeProduit", new TypeProduit());
        return "typeproduit/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("typeProduit", typeProduitService.findById(id).orElseThrow());
        return "typeproduit/form";
    }

    @PostMapping("/save")
    public String saveTypeProduit(@ModelAttribute TypeProduit typeProduit) {
        typeProduitService.save(typeProduit);
        return "redirect:/typeproduits";
    }

    @GetMapping("/delete/{id}")
    public String deleteTypeProduit(@PathVariable Integer id) {
        typeProduitService.deleteById(id);
        return "redirect:/typeproduits";
    }
} 