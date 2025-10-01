package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.ProduitDuMois;
import com.example.boulangerie.services.ProduitDuMoisService;
import com.example.boulangerie.services.ProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/produits-du-mois")
public class ProduitDuMoisController {
    
    @Autowired
    private ProduitDuMoisService produitDuMoisService;
    
    @Autowired
    private ProduitService produitService;
    
    @GetMapping
    public String index(Model model, 
                       @RequestParam(required = false) Integer mois,
                       @RequestParam(required = false) Integer annee,
                       @RequestParam(required = false) String view) {
        List<ProduitDuMois> produits;
        
        if ("expiring".equals(view)) {
            produits = produitDuMoisService.findExpiringPromotions(7);
            model.addAttribute("isExpiringView", true);
            model.addAttribute("viewTitle", "Promotions expirant dans 7 jours");
        } else if ("expired".equals(view)) {
            produits = produitDuMoisService.findExpiredPromotions();
            model.addAttribute("isExpiredView", true);
            model.addAttribute("viewTitle", "Promotions expirées");
        } else if (mois != null && annee != null) {
            produits = produitDuMoisService.findByMoisAndAnnee(mois, annee);
            model.addAttribute("moisSelectionne", mois);
            model.addAttribute("anneeSelectionnee", annee);
            model.addAttribute("viewTitle", "Promotions de " + mois + "/" + annee);
        } else {
            produits = produitDuMoisService.findCurrentPromos();
            model.addAttribute("viewTitle", "Promotions en cours");
        }
        
        // Calculer les prix promotionnels pour chaque produit
        produits.forEach(promo -> {
            BigDecimal prixPromo = produitDuMoisService.calculatePrixPromo(promo);
            model.addAttribute("prixPromo_" + promo.getIdProduitMois(), prixPromo);
        });
        
        model.addAttribute("produitsPromo", produits);
        model.addAttribute("moisCourant", LocalDate.now().getMonthValue());
        model.addAttribute("anneeCourante", LocalDate.now().getYear());
        
        return "produitdumois/index";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("produitDuMois", new ProduitDuMois());
        model.addAttribute("produits", produitService.findAll());
        model.addAttribute("moisCourant", LocalDate.now().getMonthValue());
        model.addAttribute("anneeCourante", LocalDate.now().getYear());
        return "produitdumois/form";
    }
    
    @PostMapping("/save")
    public String save(@ModelAttribute ProduitDuMois produitDuMois, RedirectAttributes redirectAttributes) {
        try {
            produitDuMoisService.save(produitDuMois);
            redirectAttributes.addFlashAttribute("success", 
                "Produit du mois " + (produitDuMois.getIdProduitMois() == null ? "ajouté" : "modifié") + " avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            if (produitDuMois.getIdProduitMois() != null) {
                return "redirect:/produits-du-mois/edit/" + produitDuMois.getIdProduitMois();
            }
            return "redirect:/produits-du-mois/add";
        }
        return "redirect:/produits-du-mois";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
        ProduitDuMois produitDuMois = produitDuMoisService.findById(id);
        if (produitDuMois == null) {
            redirectAttributes.addFlashAttribute("error", "Produit du mois non trouvé");
            return "redirect:/produits-du-mois";
        }
        
        model.addAttribute("produitDuMois", produitDuMois);
        model.addAttribute("produits", produitService.findAll());
        return "produitdumois/form";
    }
    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            ProduitDuMois produitDuMois = produitDuMoisService.findById(id);
            if (produitDuMois != null) {
                produitDuMoisService.delete(produitDuMois);
                redirectAttributes.addFlashAttribute("success", "Produit du mois supprimé avec succès!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Produit du mois non trouvé");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        return "redirect:/produits-du-mois";
    }
    
    @GetMapping("/produit/{idProduit}")
    public String findByProduit(@PathVariable Integer idProduit, Model model) {
        List<ProduitDuMois> produits = produitDuMoisService.findByProduitId(idProduit);
        model.addAttribute("produitsPromo", produits);
        model.addAttribute("viewTitle", "Historique des promotions du produit");
        return "produitdumois/index";
    }
}
