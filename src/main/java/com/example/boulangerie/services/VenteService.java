package com.example.boulangerie.services;

import com.example.boulangerie.entities.Vente;
import com.example.boulangerie.repositories.VenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class VenteService {
    
    @Autowired
    private VenteRepository venteRepository;
    
    public List<Vente> findAllVente() {
        return venteRepository.findAllVente();
    }
    
    public List<Vente> findVenteParTypeProduit(Integer idTypeProduit) {
        return venteRepository.findVenteParTypeProduit(idTypeProduit);
    }
    
    public List<Vente> findVenteParProduit(Integer idProduit) {
        return venteRepository.findVenteParProduit(idProduit);
    }
    
    public List<Vente> findVenteParDate(LocalDate date) {
        return venteRepository.findVenteParDate(date);
    }
    
    public Optional<Vente> findById(Integer id) {
        return venteRepository.findById(id);
    }
    
    public Vente save(Vente vente) {
        return venteRepository.save(vente);
    }
    
    public void delete(Vente vente) {
        venteRepository.delete(vente);
    }
}
