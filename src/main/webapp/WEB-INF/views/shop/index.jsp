<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">
    <div class="row">
        <!-- Liste des produits -->
        <div class="col-md-8">
            <h2>Nos Produits</h2>
            <div class="row">
                <c:forEach items="${produits}" var="produit">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body" data-produit-id="${produit.idProduit}">
                                <h5 class="card-title">${produit.nomProduit}</h5>
                                <p class="card-text prix">Prix: ${produit.prixVente}</p>
                                <p class="card-text stock">
                                    Stock disponible: 
                                    <c:choose>
                                        <c:when test="${stocks[produit.idProduit] != null}">
                                            ${stocks[produit.idProduit].quantiteStock}
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="input-group" style="width: 120px;">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="diminuerQuantite(${produit.idProduit})">-</button>
                                        <input type="number" 
                                               class="form-control form-control-sm text-center quantite-input"
                                               value="1" 
                                               min="1" 
                                               max="${stocks[produit.idProduit].quantiteStock}"
                                               data-produit-id="${produit.idProduit}">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="augmenterQuantite(${produit.idProduit})">+</button>
                                    </div>
                                    <button class="btn btn-primary" onclick="ajouterAuPanier(${produit.idProduit})">
                                        Ajouter au panier
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <!-- Panier -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Panier</h5>
                </div>
                <div class="card-body" id="panier">
                    <!-- Le contenu du panier sera géré en JavaScript -->
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Gestion du panier
let panier = [];

function diminuerQuantite(produitId) {
    const input = document.querySelector(`input[data-produit-id="${produitId}"]`);
    if (input && input.value > 1) {
        input.value = parseInt(input.value) - 1;
    }
}

function augmenterQuantite(produitId) {
    const input = document.querySelector(`input[data-produit-id="${produitId}"]`);
    if (input) {
        const max = parseInt(input.max);
        const currentValue = parseInt(input.value);
        if (currentValue < max) {
            input.value = currentValue + 1;
        }
    }
}

function ajouterAuPanier(produitId) {
    const cardBody = document.querySelector(`.card-body[data-produit-id="${produitId}"]`);
    if (!cardBody) return;

    const input = cardBody.querySelector('.quantite-input');
    if (!input) return;

    const quantite = parseInt(input.value);
    const prixText = cardBody.querySelector('.card-text.prix').textContent;
    const prix = parseFloat(prixText.split(':')[1].trim());
    
    const produit = {
        id: produitId,
        nom: cardBody.querySelector('.card-title').textContent.trim(),
        prix: prix,
        quantite: quantite
    };

    const existingItem = panier.find(item => item.id === produitId);
    if (existingItem) {
        const stockMax = parseInt(input.max);
        const nouvelleQuantite = existingItem.quantite + quantite;
        
        if (nouvelleQuantite <= stockMax) {
            existingItem.quantite = nouvelleQuantite;
        } else {
            alert('La quantité demandée dépasse le stock disponible');
            return;
        }
    } else {
        panier.push(produit);
    }

    input.value = 1;
    afficherPanier();
}

function supprimerDuPanier(produitId) {
    panier = panier.filter(item => item.id !== produitId);
    afficherPanier();
}

function afficherPanier() {
    const panierElement = document.getElementById('panier');
    
    if (panier.length === 0) {
        panierElement.innerHTML = `
            <div class="text-center text-muted py-5">
                <i class="bi bi-cart-x fs-1"></i>
                <p class="mt-2">Votre panier est vide</p>
            </div>`;
        return;
    }

    let html = '';
    let total = 0;

    panier.forEach(item => {
        const sousTotal = item.prix * item.quantite;
        total += sousTotal;
        
        html += `
            <div class="card mb-2">
                <div class="card-body p-2">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="mb-1">${item.nom}</h6>
                            <p class="mb-0">Quantité: ${item.quantite}</p>
                        </div>
                        <div class="text-end">
                            <button onclick="supprimerDuPanier(${item.id})" 
                                    class="btn btn-sm btn-outline-danger mb-2">
                                <i class="bi bi-trash"></i>
                            </button>
                            <div>
                                <small class="text-muted d-block">Prix: ${item.prix} Ar</small>
                                <strong>Total: ${sousTotal} Ar</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;
    });

    html += `
        <div class="border-top pt-3 mt-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Total</h5>
                <h5 class="mb-0">${total} Ar</h5>
            </div>
            <button onclick="validerCommande()" class="btn btn-success w-100 mt-3">
                Valider la commande
            </button>
        </div>`;

    panierElement.innerHTML = html;
}

// Initialiser l'affichage du panier
document.addEventListener('DOMContentLoaded', afficherPanier);
</script>

<jsp:include page="../layout/footer.jsp" /> 