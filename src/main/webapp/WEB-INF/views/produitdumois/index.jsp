<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">🌟 Produits du Mois</h2>
        <a href="/produits-du-mois/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Ajouter un produit du mois
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <c:forEach items="${produitsPromo}" var="promo">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="position-relative">
                        <c:if test="${not empty promo.produit.image}">
                            <img src="${promo.produit.image}" class="card-img-top" alt="${promo.produit.nomProduit}" style="height: 200px; object-fit: cover;">
                        </c:if>
                        <div class="position-absolute top-0 end-0 p-2">
                            <span class="badge bg-danger">-${promo.remise}%</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">${promo.produit.nomProduit}</h5>
                        <p class="card-text">${promo.description}</p>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-muted">Prix normal: ${promo.produit.prixVente} Ar</span>
                            <span class="text-danger fw-bold">
                                Prix promo: ${promo.produit.prixVente * (1 - promo.remise/100)} Ar
                            </span>
                        </div>
                        <p class="card-text">
                            <small class="text-muted">
                                <i class="far fa-calendar-alt"></i> 
                                Du ${promo.dateDebut.format(java.time.format.DateTimeFormatter.ofPattern('dd/MM/yyyy'))}
                                au ${promo.dateFin.format(java.time.format.DateTimeFormatter.ofPattern('dd/MM/yyyy'))}
                            </small>
                        </p>
                    </div>
                    <div class="card-footer bg-transparent border-top-0">
                        <div class="d-flex justify-content-between">
                            <a href="/produits-du-mois/edit/${promo.idProduitMois}" class="btn btn-outline-warning">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="/produits-du-mois/delete/${promo.idProduitMois}" 
                               class="btn btn-outline-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit du mois?')">
                                <i class="fas fa-trash"></i> Supprimer
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
