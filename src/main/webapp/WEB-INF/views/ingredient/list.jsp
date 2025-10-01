<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-egg-fried"></i>
            Liste des Ingrédients
        </h2>
        <a href="/ingredients/new" class="btn btn-primary">
            <i class="bi bi-plus-circle-fill"></i>
            Nouvel Ingrédient
        </a>
    </div>

    <!-- Recherche -->
    <div class="card mb-4">
        <div class="card-body">
            <form action="/ingredients" method="get" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">
                        <i class="bi bi-search"></i>
                        Nom de l'ingrédient
                    </label>
                    <input type="text" name="searchNom" class="form-control" 
                           value="${searchNom}" placeholder="Rechercher par nom...">
                </div>
                <div class="col-md-4">
                    <label class="form-label">
                        <i class="bi bi-box-seam"></i>
                        Produit
                    </label>
                    <input type="text" name="searchProduit" class="form-control" 
                           value="${searchProduit}" placeholder="Rechercher par produit...">
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="bi bi-search"></i>
                        Rechercher
                    </button>
                    <a href="/ingredients" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i>
                        Réinitialiser
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Liste des ingrédients -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table" id="ingredientsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Unité</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${ingredients}" var="ingredient">
                            <tr>
                                <td>${ingredient.idIngredient}</td>
                                <td>
                                    <i class="bi bi-egg-fried text-primary"></i>
                                    ${ingredient.nomIngredient}
                                </td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="bi bi-rulers"></i>
                                        ${ingredient.unite.unite}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/ingredients/edit/${ingredient.idIngredient}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil-square"></i>
                                            Modifier
                                        </a>
                                        <button onclick="confirmDelete(${ingredient.idIngredient})" 
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
    if (confirm('Êtes-vous sûr de vouloir supprimer cet ingrédient ?')) {
        window.location.href = `/ingredients/delete/${id}`;
    }
}
</script>

<jsp:include page="../layout/footer.jsp" />