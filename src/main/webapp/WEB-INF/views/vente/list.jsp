<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Ventes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .type-title {
            color: #0d6efd;
            margin: 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #0d6efd;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container mt-4">
        <h2>Liste des Ventes</h2>
        
        <!-- Filtrage par type -->
        <form action="${pageContext.request.contextPath}/ventes/list" method="get" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <label for="typeProduit" class="form-label">Type de produit :</label>
                    <select name="idTypeProduit" id="typeProduit" class="form-select" onchange="this.form.submit()">
                        <option value="">Tous les types</option>
                        <c:forEach items="${typesProduits}" var="type">
                            <option value="${type.idTypeProduit}" ${type.idTypeProduit == selectedType ? 'selected' : ''}>
                                ${type.nomTypeProduit}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </form>

        <!-- Affichage du type sélectionné
        <c:if test="${not empty selectedTypeName}">
            <h3 class="type-title">Type sélectionné : ${selectedTypeName}</h3>
        </c:if>

        <!-- Messages de succès/erreur -->
        <!-- <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if> -->

        <!-- Tableau des ventes -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Produit</th>
                    <th>Type de Produit</th>
                    <th>Date</th>
                    <th>Prix de Vente</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${ventes}" var="vente">
                    <c:out value="${ventes}" />
                    <tr>
                        <td>${vente.produit.nomProduit}</td>
                        <td>${vente.produit.typeProduit.nomTypeProduit}</td>
                        <td><fmt:formatDate value="${vente.dateVente}" pattern="dd/MM/yyyy" /></td>
                        <td><fmt:formatNumber value="${vente.produit.prixVente}" type="currency" currencySymbol="Ar" /></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/ventes/edit/${vente.idVente}" class="btn btn-sm btn-primary">
                                <i class="bi bi-pencil"></i> Modifier
                            </a>
                            <a href="${pageContext.request.contextPath}/ventes/delete/${vente.idVente}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette vente ?')">
                                <i class="bi bi-trash"></i> Supprimer
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <!-- Bouton pour ajouter une nouvelle vente
        <a href="${pageContext.request.contextPath}/ventes/add" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Nouvelle Vente
        </a>
    </div> -->
    
    <jsp:include page="../layout/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
