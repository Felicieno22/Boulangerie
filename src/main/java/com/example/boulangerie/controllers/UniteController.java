package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Unite;
import com.example.boulangerie.services.UniteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/unites")
public class UniteController {
    @Autowired
    private UniteService uniteService;

    @GetMapping
    public String listUnites(Model model) {
        model.addAttribute("unites", uniteService.findAll());
        return "unite/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("unite", new Unite());
        return "unite/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("unite", uniteService.findById(id).orElseThrow());
        return "unite/form";
    }

    @PostMapping("/save")
    public String saveUnite(@ModelAttribute Unite unite) {
        uniteService.save(unite);
        return "redirect:/unites";
    }

    @GetMapping("/delete/{id}")
    public String deleteUnite(@PathVariable Integer id) {
        uniteService.deleteById(id);
        return "redirect:/unites";
    }
} 