<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<h2>${produit.idProduit == null ? 'Nouveau Produit' : 'Modifier Produit'}</h2>

<form:form action="/produits/save" method="post" modelAttribute="produit" enctype="multipart/form-data">
    <form:hidden path="idProduit" />
    
    <div class="mb-3">
        <label class="form-label">Nom du Produit</label>
        <form:input path="nomProduit" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Prix de Revient</label>
        <form:input path="prixRevient" type="number" step="0.01" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Prix de Vente</label>
        <form:input path="prixVente" type="number" step="0.01" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Type de Produit</label>
        <form:select path="typeProduit.idTypeProduit" class="form-control" required="true">
            <form:options items="${typeProduits}" itemValue="idTypeProduit" itemLabel="nomTypeProduit" />
        </form:select>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Image</label>
        <input type="file" name="imageFile" class="form-control" accept="image/*" />
        <form:hidden path="image" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/produits" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 