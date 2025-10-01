package com.example.boulangerie.services;

import com.example.boulangerie.entities.TypeProduit;
import com.example.boulangerie.repositories.TypeProduitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TypeProduitService {
    @Autowired
    private TypeProduitRepository typeProduitRepository;

    public List<TypeProduit> findAll() {
        return typeProduitRepository.findAll();
    }
    
    public List<TypeProduit> findAllOrderByNomType() {
        return typeProduitRepository.findAllOrderByNomType();
    }

    public Optional<TypeProduit> findById(Integer id) {
        return typeProduitRepository.findById(id);
    }

    public TypeProduit save(TypeProduit typeProduit) {
        return typeProduitRepository.save(typeProduit);
    }

    public void deleteById(Integer id) {
        typeProduitRepository.deleteById(id);
    }
}