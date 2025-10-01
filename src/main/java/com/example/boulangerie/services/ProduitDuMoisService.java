package com.example.boulangerie.services;

import com.example.boulangerie.entities.ProduitDuMois;
import com.example.boulangerie.repositories.ProduitDuMoisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

@Service
public class ProduitDuMoisService {
    
    @Autowired
    private ProduitDuMoisRepository produitDuMoisRepository;
    
    public List<ProduitDuMois> findAll() {
        return produitDuMoisRepository.findAll();
    }
    
    public ProduitDuMois findById(Integer id) {
        return produitDuMoisRepository.findById(id).orElse(null);
    }
    
    public List<ProduitDuMois> findByMoisAndAnnee(Integer mois, Integer annee) {
        return produitDuMoisRepository.findByMoisAndAnnee(mois, annee);
    }
    
    public List<ProduitDuMois> findCurrentPromos() {
        return produitDuMoisRepository.findCurrentPromos(LocalDate.now());
    }
    
    public List<ProduitDuMois> findByProduitId(Integer idProduit) {
        return produitDuMoisRepository.findByProduitId(idProduit);
    }
    
    public List<ProduitDuMois> findExpiringPromotions(int daysThreshold) {
        LocalDate today = LocalDate.now();
        LocalDate endDate = today.plusDays(daysThreshold);
        return produitDuMoisRepository.findExpiringPromotions(today, endDate);
    }
    
    public List<ProduitDuMois> findExpiredPromotions() {
        return produitDuMoisRepository.findExpiredPromotions(LocalDate.now());
    }
    
    public ProduitDuMois save(ProduitDuMois produitDuMois) throws Exception {
        // Vérifier si le produit n'a pas déjà une promotion sur cette période
        boolean hasOverlap = produitDuMoisRepository.existsOverlappingPromotion(
            produitDuMois.getProduit().getIdProduit(),
            produitDuMois.getDateDebut(),
            produitDuMois.getDateFin()
        );
        
        if (hasOverlap && (produitDuMois.getIdProduitMois() == null)) {
            throw new Exception("Ce produit a déjà une promotion active sur cette période");
        }
        
        // Vérifier que la date de fin est après la date de début
        if (produitDuMois.getDateFin().isBefore(produitDuMois.getDateDebut())) {
            throw new Exception("La date de fin doit être postérieure à la date de début");
        }
        
        // Vérifier que la remise est entre 0 et 100
        if (produitDuMois.getRemise() < 0 || produitDuMois.getRemise() > 100) {
            throw new Exception("La remise doit être comprise entre 0 et 100%");
        }
        
        // Vérifier que la date de début n'est pas dans le passé pour les nouvelles promotions
        if (produitDuMois.getIdProduitMois() == null && 
            produitDuMois.getDateDebut().isBefore(LocalDate.now())) {
            throw new Exception("La date de début ne peut pas être dans le passé");
        }
        
        return produitDuMoisRepository.save(produitDuMois);
    }
    
    public void delete(ProduitDuMois produitDuMois) {
        produitDuMoisRepository.delete(produitDuMois);
    }
    
    public void deleteById(Integer id) {
        produitDuMoisRepository.deleteById(id);
    }
    
    public BigDecimal calculatePrixPromo(ProduitDuMois produitDuMois) {
        BigDecimal prixNormal = produitDuMois.getProduit().getPrixVente();
        BigDecimal remise = BigDecimal.valueOf(produitDuMois.getRemise()).divide(BigDecimal.valueOf(100));
        return prixNormal.multiply(BigDecimal.ONE.subtract(remise)).setScale(0, RoundingMode.HALF_UP);
    }
}
