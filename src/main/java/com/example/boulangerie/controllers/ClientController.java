package com.example.boulangerie.controllers;

import com.example.boulangerie.entities.Client;
import com.example.boulangerie.services.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/clients")
public class ClientController {
    @Autowired
    private ClientService clientService;

    @GetMapping
    public String listClients(Model model) {
        model.addAttribute("clients", clientService.findAll());
        return "client/list"; // Renvoie la vue JSP pour la liste des clients
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("client", new Client());
        return "client/form"; // Renvoie la vue JSP pour le formulaire de création
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("client", clientService.findById(id).orElseThrow());
        return "client/form"; // Renvoie la vue JSP pour le formulaire de modification
    }

    @PostMapping("/save")
    public String saveClient(@ModelAttribute Client client) {
        clientService.save(client);
        return "redirect:/clients"; // Redirige vers la liste des clients après la sauvegarde
    }

    @GetMapping("/delete/{id}")
    public String deleteClient(@PathVariable Integer id) {
        clientService.deleteById(id);
        return "redirect:/clients"; // Redirige vers la liste des clients après la suppression
    }
} 