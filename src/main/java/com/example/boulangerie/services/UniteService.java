package com.example.boulangerie.services;

import com.example.boulangerie.entities.Unite;
import com.example.boulangerie.repositories.UniteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UniteService {
    @Autowired
    private UniteRepository uniteRepository;

    public List<Unite> findAll() {
        return uniteRepository.findAll();
    }

    public Optional<Unite> findById(Integer id) {
        return uniteRepository.findById(id);
    }

    public Unite save(Unite unite) {
        return uniteRepository.save(unite);
    }

    public void deleteById(Integer id) {
        uniteRepository.deleteById(id);
    }
} 