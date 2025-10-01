<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-box-seam"></i>
            Liste des Produits
        </h2>
        <a href="/produits/new" class="btn btn-primary">
            <i class="bi bi-plus-circle-fill"></i>
            Nouveau Produit
        </a>
    </div>

    <!-- Recherche -->
    <div class="card mb-4">
        <div class="card-body">
            <form action="/produits" method="get" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">
                        <i class="bi bi-search"></i>
                        Nom du produit
                    </label>
                    <input type="text" name="searchNom" class="form-control" 
                           value="${searchNom}" placeholder="Rechercher par nom...">
                </div>
                <div class="col-md-4">
                    <label class="form-label">
                        <i class="bi bi-egg-fried"></i>
                        Ingrédient
                    </label>
                    <input type="text" name="searchIngredient" class="form-control" 
                           value="${searchIngredient}" placeholder="Rechercher par ingrédient...">
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="bi bi-search"></i>
                        Rechercher
                    </button>
                    <a href="/produits" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i>
                        Réinitialiser
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Liste des produits -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table" id="produitsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prix de Revient</th>
                            <th>Prix de Vente</th>
                            <th>Type de Produit</th>
                            <th>Image</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${produits}" var="produit">
                            <tr>
                                <td>${produit.idProduit}</td>
                                <td>
                                    <i class="bi bi-box-seam text-primary"></i>
                                    ${produit.nomProduit}
                                </td>
                                <td>${produit.prixRevient} Ar</td>
                                <td>${produit.prixVente} Ar</td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="bi bi-tag-fill"></i>
                                        ${produit.typeProduit.nomTypeProduit}
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${not empty produit.image}">
                                        <img src="${produit.image}" alt="${produit.nomProduit}" 
                                             class="img-thumbnail" style="max-width: 50px;">
                                    </c:if>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/produits/edit/${produit.idProduit}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil-square"></i>
                                            Modifier
                                        </a>
                                        <button onclick="confirmDelete(${produit.idProduit})" 
                                                class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash3"></i>
                                            Supprimer
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function confirmDelete(id) {
    if (confirm('Êtes-vous sûr de vouloir supprimer ce produit ?')) {
        window.location.href = `/produits/delete/${id}`;
    }
}
</script>

<jsp:include page="../layout/footer.jsp" />