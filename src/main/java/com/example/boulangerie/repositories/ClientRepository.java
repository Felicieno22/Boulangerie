package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<Client, Integer> {
} 