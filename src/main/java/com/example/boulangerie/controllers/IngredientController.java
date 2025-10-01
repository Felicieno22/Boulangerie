package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Ingredient;
import com.example.boulangerie.entities.Unite;
import com.example.boulangerie.services.IngredientService;
import com.example.boulangerie.services.UniteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/ingredients")
public class IngredientController {
    private static final Logger logger = LoggerFactory.getLogger(IngredientController.class);
    
    @Autowired
    private IngredientService ingredientService;
    
    @Autowired
    private UniteService uniteService;

    @GetMapping
    public String listIngredients(Model model) {
        logger.info("Accessing ingredient list page");
        List<Ingredient> ingredients = ingredientService.findAll();
        logger.info("Found {} ingredients", ingredients.size());
        model.addAttribute("ingredients", ingredients);
        
        List<Unite> unites = uniteService.findAll();
        logger.info("Found {} unites", unites.size());
        model.addAttribute("unites", unites);
        
        return "ingredient/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        logger.info("Accessing new ingredient form");
        model.addAttribute("ingredient", new Ingredient());
        model.addAttribute("unites", uniteService.findAll());
        return "ingredient/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        logger.info("Accessing edit form for ingredient with id: {}", id);
        model.addAttribute("ingredient", ingredientService.findById(id).orElseThrow());
        model.addAttribute("unites", uniteService.findAll());
        return "ingredient/form";
    }

    @PostMapping("/save")
    public String saveIngredient(@ModelAttribute Ingredient ingredient) {
        logger.info("Saving ingredient: {}", ingredient.getNomIngredient());
        ingredientService.save(ingredient);
        return "redirect:/ingredients";
    }

    @GetMapping("/delete/{id}")
    public String deleteIngredient(@PathVariable Integer id) {
        logger.info("Deleting ingredient with id: {}", id);
        ingredientService.deleteById(id);
        return "redirect:/ingredients";
    }
}