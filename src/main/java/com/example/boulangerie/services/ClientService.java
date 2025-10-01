package com.example.boulangerie.services;

import com.example.boulangerie.entities.Client;
import com.example.boulangerie.repositories.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClientService {
    @Autowired
    private ClientRepository clientRepository;
    
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public List<Client> findAll() {
        return clientRepository.findAll();
    }

    public Optional<Client> findById(Integer id) {
        return clientRepository.findById(id);
    }

    public Client save(Client client) {
        // Crypter le mot de passe avant de sauvegarder
        client.setPassword(passwordEncoder.encode(client.getPassword()));
        return clientRepository.save(client);
    }

    public Client update(Integer id, Client client) {
        return clientRepository.findById(id)
            .map(existingClient -> {
                client.setIdClient(id);
                // Si le mot de passe a été modifié, le crypter
                if (!client.getPassword().equals(existingClient.getPassword())) {
                    client.setPassword(passwordEncoder.encode(client.getPassword()));
                }
                return clientRepository.save(client);
            })
            .orElseThrow(() -> new RuntimeException("Client non trouvé"));
    }

    public void deleteById(Integer id) {
        clientRepository.deleteById(id);
    }
    
} 