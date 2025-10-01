package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Produit;
import com.example.boulangerie.entities.TypeProduit;
import com.example.boulangerie.entities.Vente;
import com.example.boulangerie.services.ProduitService;
import com.example.boulangerie.services.TypeProduitService;
import com.example.boulangerie.services.VenteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/ventes")
public class VenteController {

    @Autowired
    private VenteService venteService;

    @Autowired
    private TypeProduitService typeProduitService;
    
    @Autowired
    private ProduitService produitService;

    @GetMapping("")
    public String index() {
        return "redirect:/ventes/list";
    }

    @GetMapping("/list")
    public String listVentes(Model model, 
                           @RequestParam(required = false) Integer idTypeProduit,
                           @RequestParam(required = false) LocalDate date) {
        // Récupérer les types de produits triés par nom
        List<TypeProduit> typesProduits = typeProduitService.findAllOrderByNomType();
        model.addAttribute("typesProduits", typesProduits);
        
        // Si un type est sélectionné, récupérer son nom pour l'affichage
        if (idTypeProduit != null) {
            TypeProduit selectedType = typeProduitService.findById(idTypeProduit)
                .orElse(null);
            if (selectedType != null) {
                model.addAttribute("selectedTypeName", selectedType.getNomTypeProduit());
            }
        }
        
        List<Vente> ventes;
        if (idTypeProduit != null) {
            ventes = venteService.findVenteParTypeProduit(idTypeProduit);
            model.addAttribute("selectedType", idTypeProduit);
        } else if (date != null) {
            ventes = venteService.findVenteParDate(date);
            model.addAttribute("selectedDate", date);
        } else {
            ventes = venteService.findAllVente();
        }
        model.addAttribute("ventes", ventes);
        
        return "vente/list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model) {
        List<Produit> produits = produitService.findAll();
        model.addAttribute("produits", produits);
        model.addAttribute("vente", new Vente());
        return "vente/form";
    }
    
    @PostMapping("/save")
    public String saveVente(@ModelAttribute Vente vente, RedirectAttributes redirectAttributes) {
        try {
            if (vente.getDateVente() == null) {
                vente.setDateVente(LocalDate.now());
            }
            venteService.save(vente);
            redirectAttributes.addFlashAttribute("success", "Vente enregistrée avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de l'enregistrement de la vente: " + e.getMessage());
        }
        return "redirect:/ventes/list";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Optional<Vente> venteOpt = venteService.findById(id);
        if (!venteOpt.isPresent()) {
            throw new RuntimeException("Vente non trouvée");
        }
        List<Produit> produits = produitService.findAll();
        
        model.addAttribute("vente", venteOpt.get());
        model.addAttribute("produits", produits);
        return "vente/form";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteVente(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Vente> vente = venteService.findById(id);
            if (vente.isPresent()) {
                venteService.delete(vente.get());
                redirectAttributes.addFlashAttribute("success", "Vente supprimée avec succès");
            } else {
                redirectAttributes.addFlashAttribute("error", "Vente non trouvée");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression de la vente: " + e.getMessage());
        }
        return "redirect:/ventes/list";
    }
}
