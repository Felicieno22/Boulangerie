<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<h2>${formule.idFormule == null ? 'Nouvelle Formule' : 'Modifier Formule'}</h2>

<form:form action="/formules/save" method="post" modelAttribute="formule">
    <form:hidden path="idFormule" />
    
    <div class="mb-3">
        <label class="form-label">Produit</label>
        <form:select path="produit.idProduit" class="form-control" required="true">
            <form:options items="${produits}" itemValue="idProduit" itemLabel="nomProduit" />
        </form:select>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Ingrédient</label>
        <form:select path="ingredient.idIngredient" class="form-control" required="true">
            <form:options items="${ingredients}" itemValue="idIngredient" itemLabel="nomIngredient" />
        </form:select>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Quantité</label>
        <form:input path="quantite" type="number" step="0.01" class="form-control" required="true" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/formules" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 